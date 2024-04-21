import 'dart:async';
import 'dart:convert';
import 'package:dailyme/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/services/urls.dart';
import 'package:dailyme/services/auth.dart';
import 'package:dailyme/models/api_response.dart';
import 'package:dailyme/services/DataDecryptor.dart';
import 'package:dailyme/services/TokenHandler.dart';
import 'package:dailyme/services/urls.dart';

class Today extends StatefulWidget {
  

  @override
  State<Today> createState() => _TodayState();
}
class _TodayState extends State<Today> {
  Future<List<dynamic>>? todoToday; // Future for fetching todo data

  @override
  void initState() {
    super.initState();
    // Call the function to fetch todo data
    todoToday = fetchTodoData();
  }

  Future<List<dynamic>> fetchTodoData() async {
    dynamic todoDetails = await GetData(todoList);
    int status = todoDetails.statusCode;

    if ([200, 201, 204].contains(status)) {
      // Parse the todoDetails JSON data
      final jsonData = jsonDecode(todoDetails.body);
      decryptor decode = decryptor();
      Map<String, dynamic> data = await decode.decrypt(jsonData['data']);
      return data['todoToday']; // Return the todo data
    } else {
      ApiResponse apiResponse = ApiResponse();
      await apiResponse.errorData(context, todoDetails);
      throw Exception('Failed to fetch todo data');
    }
  }

Future<void> _refreshTodoData() async {
    setState(() {
      todoToday = fetchTodoData();
    });
  }

Future<void> _submitFormAndRefreshData(Map<String, dynamic> data) async {
    TokenHandler tokenHandler = TokenHandler(context);
    await tokenHandler.submitCommonForm(data, todoUpdate);
    await _refreshTodoData();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color:bg1,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's Actions", style: formHeading,),
                // Text("27/07/2024"),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .1,
                      height: MediaQuery.of(context).size.height * .55,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(96, 180, 39, 39),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(20.0),
                        ),
                      ),
                      child: const Align(
                        alignment: Alignment.topCenter,
                        child: Icon(Icons.circle_outlined),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .8,
                    height: MediaQuery.of(context).size.height * .55,
                    decoration: const BoxDecoration(
                      color: Colors.black38,
                    ),
                    child: RefreshIndicator(
                      onRefresh: fetchTodoData,
                      child: SingleChildScrollView(
                        child: FutureBuilder<List<dynamic>>(
                          future: todoToday, // Set the future to fetch todo data
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              // Build UI components based on the fetched data
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var item in snapshot.data!) ...[
                                    Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item['todoName'].toString(),
                                              style: paragraph,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              child: FloatingActionButton(
                                                shape: const CircleBorder(),
                                                backgroundColor: bg1,
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.upgrade,
                                                    size: 30.0,
                                                    color: iconColor1,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                        context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Confirmation', style: formHeading,),
                                                        content: const Text(
                                                          'Do you complete?',
                                                          style: TextStyle(
                                                            color:
                                                                kSuccessColor,
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: Text('OK'),
                                                            onPressed: () {
                                                              Map<String, dynamic> data = {
                                                                "guId": item['guId'].toString(),
                                                              };
                                                              _submitFormAndRefreshData(data);
                                                              // Navigator.of(context).pop();
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: const Text(
                                                                'Cancel'),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    const Divider(
                                      color: kDark,
                                      thickness: 1,
                                      height: 1.0,
                                      indent: 10,
                                      endIndent: 20,
                                    ),
                                  ],
                                ],
                              );
                            } else {
                              return const Center(child: Text('No data available'));
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

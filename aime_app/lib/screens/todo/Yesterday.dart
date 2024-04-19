import 'dart:async';
import 'dart:convert';
import 'package:dailyme/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/services/urls.dart';
import 'package:dailyme/services/auth.dart';
import 'package:dailyme/models/api_response.dart';
import 'package:dailyme/services/DataDecryptor.dart';

class Yesterday extends StatefulWidget {
  @override
  State<Yesterday> createState() => _YesterdayState();
}

class _YesterdayState extends State<Yesterday> {
  Future<List<dynamic>>? todoYesterday; // Future for fetching todo data
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Call the function to fetch todo data
    todoYesterday = fetchTodoData();
  }

  Future<List<dynamic>> fetchTodoData() async {
    setState(() {
      isLoading = true;
    });
    dynamic todoDetails = await GetData(todoList);
    int status = todoDetails.statusCode;

    if ([200, 201, 204].contains(status)) {
      // Parse the todoDetails JSON data
      final jsonData = jsonDecode(todoDetails.body);
      decryptor decode = decryptor();
      Map<String, dynamic> data = await decode.decrypt(jsonData['data']);
      setState(() {
        isLoading = false;
      });
      return data['todoYesterday']; // Return the todo data
    } else {
      ApiResponse apiResponse = ApiResponse();
      await apiResponse.errorData(context, todoDetails);
      throw Exception('Failed to fetch todo data');
    }
  }

  Future<void> _refreshTodoData() async {
    setState(() {
      todoYesterday = fetchTodoData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Center(
        child: CircularProgressIndicator(),
      ),
      replacement: RefreshIndicator(
        onRefresh: _refreshTodoData,
        child: Card(
          color: bg1,
          elevation: 5.0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pending Actions", style: formHeading,),
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
                        child: SingleChildScrollView(
                          child: FutureBuilder<List<dynamic>>(
                            future:
                                todoYesterday, // Set the future to fetch todo data
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                // Build UI components based on the fetched data
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var item in snapshot.data!) ...[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child:
                                            Text(item['todoName'].toString(), style: paragraph,),
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
                                return const Center(
                                    child: Text('No data available'));
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

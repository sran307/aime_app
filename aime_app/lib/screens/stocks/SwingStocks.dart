import 'package:flutter/material.dart';
import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/constants/appBar.dart';
import 'package:dailyme/constants/navBar/CustomBottomNavBar.dart';

import 'dart:async';
import 'dart:convert';
import 'package:dailyme/services/urls.dart';
import 'package:dailyme/services/auth.dart';
import 'package:dailyme/models/api_response.dart';
import 'package:dailyme/services/DataDecryptor.dart';
import 'package:dailyme/services/TokenHandler.dart';

class SwingStocks extends StatefulWidget {
  const SwingStocks({super.key});

  @override
  State<SwingStocks> createState() => _SwingStocksState();
}

class _SwingStocksState extends State<SwingStocks> {
  Future<List<dynamic>>? swingStocks; // Future for fetching todo data

  @override
  void initState() {
    super.initState();
    // Call the function to fetch todo data
    swingStocks = fetchSwingStock();
  }

  Future<List<dynamic>> fetchSwingStock() async {
    dynamic swingStocks = await GetData(swingAnalysis);
    int status = swingStocks.statusCode;
    if ([200, 201, 204].contains(status)) {
      // Parse the swingStocks JSON data
      final jsonData = jsonDecode(swingStocks.body);
      decryptor decode = decryptor();
      Map<String, dynamic> data = await decode.decrypt(jsonData['data']);
      return data['swingStocks']; // Return the todo data
    } else {
      ApiResponse apiResponse = ApiResponse();
      await apiResponse.errorData(context, swingStocks);
      return [];
    }
  }

  Future<void> _refreshSectorData() async {
    setState(() {
      swingStocks = fetchSwingStock();
    });
  }

  Future<void> _submitFormAndRefreshData(Map<String, dynamic> data) async {
    TokenHandler tokenHandler = TokenHandler(context);
    await tokenHandler.submitCommonForm(data, todoUpdate);
    await _refreshSectorData();
  }

  int _currentIndex = 6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Card(
          elevation: 5.0,
          color: bg1,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Analysed for Swing Trade",
                      style: formHeading,
                    ),
                    // Text("27/07/2024"),
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width * .01,
                          height: MediaQuery.of(context).size.height * .7,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(96, 180, 39, 39),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .8,
                        height: MediaQuery.of(context).size.height * .7,
                        decoration: const BoxDecoration(
                          color: Colors.black38,
                        ),
                        child: RefreshIndicator(
                          onRefresh: fetchSwingStock,
                          child: SingleChildScrollView(
                            child: FutureBuilder<List<dynamic>>(
                              future:
                                  swingStocks, // Set the future to fetch todo data
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (var item in snapshot.data!) ...[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                item['id'].toString()+' - '+item['stockName'].toString(),
                                                style: paragraph,
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
                                  return const Center(
                                      child: Text('No data available'));
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
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}

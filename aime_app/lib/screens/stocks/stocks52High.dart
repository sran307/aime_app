import 'package:dailyme/screens/events/EventList.dart';
import 'package:dailyme/screens/home/icon_btn_with_counter.dart';
import 'package:dailyme/screens/stocks/stockHome.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/constants/appBar.dart';
import 'package:dailyme/constants/drawer.dart';
import 'package:dailyme/constants/navBar/CustomBottomNavBar.dart';

import 'dart:async';
import 'dart:convert';
import 'package:dailyme/services/urls.dart';
import 'package:dailyme/services/auth.dart';
import 'package:dailyme/models/api_response.dart';
import 'package:dailyme/services/DataDecryptor.dart';
import 'package:dailyme/services/TokenHandler.dart';
import 'package:get/get.dart';

class Stock52High extends StatefulWidget {
  const Stock52High({super.key});

  @override
  State<Stock52High> createState() => _Stock52HighState();
}

class _Stock52HighState extends State<Stock52High> {
  Future<List<dynamic>>? stock52High; // Future for fetching todo data

  @override
  void initState() {
    super.initState();
    // Call the function to fetch todo data
    stock52High = fetch52LowStock();
  }

  Future<List<dynamic>> fetch52LowStock() async {
    dynamic stock52High = await GetData(stock52HighUrl);
    int status = stock52High.statusCode;
    if ([200, 201, 204].contains(status)) {
      // Parse the stock52High JSON data
      final jsonData = jsonDecode(stock52High.body);
      decryptor decode = decryptor();
      Map<String, dynamic> data = await decode.decrypt(jsonData['data']);
      return data['stock52High']; // Return the todo data
    } else {
      ApiResponse apiResponse = ApiResponse();
      await apiResponse.errorData(context, stock52High);
      return [];
    }
  }

  Future<void> _refreshSectorData() async {
    setState(() {
      stock52High = fetch52LowStock();
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
      drawer: const drawer(),
      body: SafeArea(
        child: Card(
          elevation: 5.0,
          color: bg1,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Stocks Near 52 Weeks High",
                      style: formHeading,
                    ),
                    IconBtnWithCounter(
                      svgSrc: Icons.arrow_back_ios_new_rounded,
                      Icolor: iconColor,
                      press: () {
                        Get.to( stockHome(), transition: Transition.zoom);
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      // Expanded(
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width * .01,
                      //     height: MediaQuery.of(context).size.height * .7,
                      //     decoration: const BoxDecoration(
                      //       color: Color.fromARGB(96, 180, 39, 39),
                      //       borderRadius: BorderRadius.only(
                      //         topLeft: Radius.circular(10),
                      //         bottomLeft: Radius.circular(20.0),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        width: MediaQuery.of(context).size.width * .96,
                        height: MediaQuery.of(context).size.height * .7,
                        decoration: const BoxDecoration(
                          color: Colors.black38,
                        ),
                        child: RefreshIndicator(
                          onRefresh: fetch52LowStock,
                          child: SingleChildScrollView(
                            child: FutureBuilder<List<dynamic>>(
                              future:
                                  stock52High, // Set the future to fetch todo data
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
                                                item['id'].toString() +
                                                    ' - ' +
                                                    item['stockName']
                                                        .toString()+' - ' +
                                                    item['amount']
                                                        .toString(),
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

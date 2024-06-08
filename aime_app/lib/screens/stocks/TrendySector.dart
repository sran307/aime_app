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

class TrendySector extends StatefulWidget {
  const TrendySector({super.key});

  @override
  State<TrendySector> createState() => _TrendySectorState();
}

class _TrendySectorState extends State<TrendySector> {
  Future<List<dynamic>>? sectors; // Future for fetching todo data

  @override
  void initState() {
    super.initState();
    // Call the function to fetch todo data
    sectors = fetchSector();
  }

  Future<List<dynamic>> fetchSector() async {
    dynamic sectorDetails = await GetData(trendySector);
    int status = sectorDetails.statusCode;
    if ([200, 201, 204].contains(status)) {
      // Parse the sectorDetails JSON data
      final jsonData = jsonDecode(sectorDetails.body);
      decryptor decode = decryptor();
      Map<String, dynamic> data = await decode.decrypt(jsonData['data']);
      return data['sectors']; // Return the todo data
    } else {
      ApiResponse apiResponse = ApiResponse();
      await apiResponse.errorData(context, sectorDetails);
      return [];
    }
  }

  Future<void> _refreshSectorData() async {
    setState(() {
      sectors = fetchSector();
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
            height: MediaQuery.of(context).size.height * 0.6,
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trending Sector",
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
                          width: MediaQuery.of(context).size.width * .05,
                          height: MediaQuery.of(context).size.height * .55,
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
                        height: MediaQuery.of(context).size.height * .55,
                        decoration: const BoxDecoration(
                          color: Colors.black38,
                        ),
                        child: RefreshIndicator(
                          onRefresh: fetchSector,
                          child: SingleChildScrollView(
                            child: FutureBuilder<List<dynamic>>(
                              future:
                                  sectors, // Set the future to fetch todo data
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
                                                item['sector'].toString(),
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

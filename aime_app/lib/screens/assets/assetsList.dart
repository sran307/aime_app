import 'dart:convert';

import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/models/api_response.dart';
import 'package:dailyme/services/DataDecryptor.dart';
import 'package:dailyme/services/auth.dart';
import 'package:dailyme/services/urls.dart';
import 'package:flutter/material.dart';

class Assetslist extends StatefulWidget {
  const Assetslist({super.key});

  @override
  State<Assetslist> createState() => _AssetslistState();
}

class _AssetslistState extends State<Assetslist> {
  Future<List<dynamic>>? assetsData;

  @override
  void initState() {
    super.initState();
    assetsData = fetchAssets();
  }

  Future<List<dynamic>> fetchAssets() async {
    dynamic assetDetails = await GetData(assetList);
    int status = assetDetails.statusCode;

    if ([200, 201, 204].contains(status)) {
      // Parse the assetDetails JSON data
      final jsonData = jsonDecode(assetDetails.body);
      decryptor decode = decryptor();
      Map<String, dynamic> data = await decode.decrypt(jsonData['data']);
      return data['data']; // Return the todo data
    } else {
      ApiResponse apiResponse = ApiResponse();
      await apiResponse.errorData(context, assetDetails);
      return [];
    }
  }

  Future<void> _refreshTodoData() async {
    setState(() {
      assetsData = fetchAssets();
    });
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: fetchAssets,
      child: SingleChildScrollView(
        child: FutureBuilder<List<dynamic>>(
          future: assetsData, // Set the future to fetch todo data
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
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * .1,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(100, 100, 100, 100),
                            borderRadius: BorderRadius.circular(5),
                            // boxShadow: const BoxShadow(color: Colors.black),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                item['asset_name'].toString(),
                                style: paragraph,
                              ),
                              Text(
                                item['asset_amount'].toString(),
                                style: paragraph,
                              ),
                              Text(
                                item['days'].toString(),
                                style: paragraph,
                              ),
                            ],
                          )),
                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       item['asset_name'].toString(),
                      //       style: paragraph,
                      //     ),
                      //   ],
                      // ),
                    ),
                    // const Divider(
                    //   color: kDark,
                    //   thickness: 1,
                    //   height: 1.0,
                    //   indent: 10,
                    //   endIndent: 10,
                    // ),
                  ],
                ],
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}

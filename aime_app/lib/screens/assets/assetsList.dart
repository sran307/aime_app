import 'dart:convert';

import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/models/api_response.dart';
import 'package:dailyme/services/DataDecryptor.dart';
import 'package:dailyme/services/TokenHandler.dart';
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

void _showPasswordDialog(value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: Text(
            'Is this asset Expired?'
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                    Map<String, dynamic> data = {
                      "guid": value,
                    };
    
                    TokenHandler tokenHandler = TokenHandler(context);
                    tokenHandler.submitCommonForm(data, assetUpdateUrl);
              },
            ),
          ],
        );
      },
    );
  }
  
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
                      child: GestureDetector(
                        onTap: (){_showPasswordDialog(item['guid']);},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * .1,
                          decoration: BoxDecoration(
                            color: item['validity'] == null
                                ? const Color.fromARGB(200, 2, 155, 53)
                                : const Color.fromARGB(150, 126, 9, 9),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Text(
                                  item['asset_name'].toString(),
                                  style: paragraph,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              Text(
                                item['asset_amount'].toString(),
                                style: paragraph,
                              ),
                            ],
                          ),
                        ),
                      ),
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
    );
  }
}

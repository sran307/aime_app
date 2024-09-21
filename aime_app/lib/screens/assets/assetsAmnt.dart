import 'dart:convert';
import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/models/api_response.dart';
import 'package:dailyme/services/DataDecryptor.dart';
import 'package:dailyme/services/auth.dart';
import 'package:dailyme/services/urls.dart';
import 'package:flutter/material.dart';

class AssetsAmnt extends StatefulWidget {
  const AssetsAmnt({super.key});

  @override
  State<AssetsAmnt> createState() => _AssetsAmntState();
}

class _AssetsAmntState extends State<AssetsAmnt> {
  Future<List<dynamic>>? assetsAmnt;

  @override
  void initState() {
    super.initState();
    assetsAmnt = fetchAssetsAmnt();
  }

  Future<List<dynamic>> fetchAssetsAmnt() async {
    try {
      dynamic assetsAmnts = await GetData(assetsAmntUrl);
      int status = assetsAmnts.statusCode;

      if ([200, 201, 204].contains(status)) {
        // Parse the assetDetails JSON data
        final jsonData = jsonDecode(assetsAmnts.body);
        decryptor decode = decryptor();
        Map<String, dynamic> data = await decode.decrypt(jsonData['data']);
        return data['data']; // Return the asset data
      } else {
        ApiResponse apiResponse = ApiResponse();
        await apiResponse.errorData(context, assetsAmnts);
        return [];
      }
    } catch (e) {
      // Handle any unexpected errors
      print('Error fetching assets: $e');
      return [];
    }
  }

  Future<void> _refreshAssetsAmnts() async {
    setState(() {
      assetsAmnt = fetchAssetsAmnt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshAssetsAmnts, // Should trigger refresh
      child: SingleChildScrollView(
        child: FutureBuilder<List<dynamic>>(
          future: assetsAmnt,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: snapshot.data!.map((item) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .15,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(150, 150, 100, 90),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Total: ${item['totalAmnt'].toString()}',
                              style: paragraph,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          const VerticalDivider(
                            color: kDark,
                            thickness: 1,
                            width:
                                1.0, // Controls the width of the vertical divider
                            indent: 10, // Top padding
                            endIndent: 20, // Bottom padding
                          ),
                          Expanded(
                            child: Text(
                              'Active: ${item['ongoing'].toString()}',
                              style: paragraph,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          const VerticalDivider(
                            color: kDark,
                            thickness: 1,
                            width:
                                1.0, // Controls the width of the vertical divider
                            indent: 10, // Top padding
                            endIndent: 20, // Bottom padding
                          ),
                          Expanded(
                            child: Text(
                              'Expired:${item['expired'].toString()}',
                              style: paragraph,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}

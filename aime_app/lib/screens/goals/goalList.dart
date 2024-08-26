import 'dart:convert';

import 'package:dailyme/models/api_response.dart';
import 'package:dailyme/services/DataDecryptor.dart';
import 'package:dailyme/services/auth.dart';
import 'package:dailyme/services/urls.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/widgets/parallax.dart';

class GoalList extends StatefulWidget {
  const GoalList({super.key});

  @override
  State<GoalList> createState() => _GoalListState();
}

class _GoalListState extends State<GoalList> {
  Future<Object>? goalsData;

  @override
  void initState() {
    super.initState();
    goalsData = fetchGoals();
  }

  Future<Object> fetchGoals() async {
    dynamic goalsDetails = await GetData(goalList);

    int status = goalsDetails.statusCode;

    if ([200, 201, 204].contains(status)) {
      // Parse the goalsDetails JSON data
      final jsonData = jsonDecode(goalsDetails.body);
      decryptor decode = decryptor();
      Map<String, dynamic> data = await decode.decrypt(jsonData['data']);
      return data; // Return the todo data
    } else {
      ApiResponse apiResponse = ApiResponse();
      await apiResponse.errorData(context, goalsDetails);
      return [];
    }
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: fetchGoals,
      child: FutureBuilder<Object>(
        future: goalsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            print(snapshot.data);
            return const ParallaxSwiper(
              images: [
                'assets/images/bg.jpg',
                'assets/images/bg.jpg',
                'assets/images/bg.jpg',
              ],
              dragToScroll: true,
              viewPortFraction: 0.85,
              padding: EdgeInsets.all(16.0),
              parallaxFactor: 10.0,
              foregroundFadeEnabled: true,
              backgroundZoomEnabled: true,
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

import 'dart:convert';

import 'package:dailyme/models/api_response.dart';
import 'package:dailyme/services/DataDecryptor.dart';
import 'package:dailyme/services/auth.dart';
import 'package:dailyme/services/urls.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/widgets/parallax.dart';
import 'package:dailyme/constants/constants.dart';


class GoalList extends StatefulWidget {
  const GoalList({super.key});

  @override
  State<GoalList> createState() => _GoalListState();
}

class _GoalListState extends State<GoalList> {
  Future<Object>? goalsData;
    dynamic dataValues=[];
    dynamic goalPendList=[];
    dynamic goalCompList=[];

    List<String> guidList1 = [];
    List<String> goalNameList1 = [];
    List<String> goalImageList1 = [];
    List<String> goalAmountList1 = [];
    List<Map<String, dynamic>> combinedData1 = [];

    List<String> guidList2 = [];
    List<String> goalNameList2 = [];
    List<String> goalImageList2 = [];
    List<String> goalAmountList2 = [];
    List<Map<String, dynamic>> combinedData2 = [];

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
    return SingleChildScrollView(child: RefreshIndicator(
      onRefresh: fetchGoals,
      child: FutureBuilder<Object>(
        future: goalsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            dataValues = snapshot.data;
            if (dataValues.containsKey('goalPend') && dataValues['goalPend'].isNotEmpty) {
                  goalPendList = dataValues['goalPend'];
                  // print(goalPendList);
                  goalPendList.forEach((item) {
                     guidList1.add(item['guid']);
                    goalNameList1.add(item['goal_name']);
                    goalAmountList1.add(item['goal_amount'].toStringAsFixed(2));
                    goalImageList1.add('assets/images/OIP.jpeg');
                  });

  // Combining the three lists into the common array
    combinedData1.add({
      'guid': guidList1,
      'heading': goalNameList1,
      'subHeading': goalAmountList1,
      'image': goalImageList1
    });
  

  // Printing the combined data
  // print('Combined Data: $combinedData');
            }
            if (dataValues.containsKey('goalComp') && dataValues['goalComp'].isNotEmpty) {
                  goalCompList = dataValues['goalComp'];
                  goalCompList.forEach((item) {
                     guidList2.add(item['guid']);
                    goalNameList2.add(item['goal_name']);
                    goalAmountList2.add(item['goal_amount'].toStringAsFixed(2));
                    goalImageList2.add('assets/images/OIP.jpeg');
                  });

  // Combining the three lists into the common array
    combinedData2.add({
      'guid': guidList2,
      'heading': goalNameList2,
      'subHeading': goalAmountList2,
      'image': goalImageList2
    });
            }

            return Column(
              children:[
                Text('Goals Pending', style:formHeading),
                if (goalPendList != null && goalPendList.isNotEmpty)
                    SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child:ParallaxSwiper(
                  dataItems: combinedData1,
                  dragToScroll: true,
                  viewPortFraction: 0.85,
                  padding: EdgeInsets.all(16.0),
                  parallaxFactor: 10.0,
                  foregroundFadeEnabled: true,
                  backgroundZoomEnabled: true,),)
                else
                  Text('No Data Available.'),
                
                Text('Goals Achieved', style:formHeading),
                if (goalCompList != null && goalCompList.isNotEmpty)
                    SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4, // 50% of the screen height
                  child:ParallaxSwiper(
                    dataItems: combinedData2,
                    dragToScroll: true,
                    viewPortFraction: 0.85,
                    padding: EdgeInsets.all(16.0),
                    parallaxFactor: 10.0,
                    foregroundFadeEnabled: true,
                    backgroundZoomEnabled: true,),)
                else
                  Text('No Data Available.')
              ],
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    ));
  }
}

import 'package:dailyme/constants/animations/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/constants/navBar/CustomBottomNavBar.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Goal extends StatefulWidget {
  const Goal({super.key});

  @override
  State<Goal> createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  get press => null;

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 5;
    return Scaffold(
      backgroundColor: kDark,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: kDark,
                expandedHeight: 500.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/bg.jpg'),
                            fit: BoxFit.cover)),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [kDark, kDark.withOpacity(0.3)])),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "NAME",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned.fill(
            child: Container(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FadeAnimation(
                    2,
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 30.0),
                      margin: EdgeInsets.all(20.0),
                      height: 30.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: kSuccessColor),
                      child: Align(
                        child: Text(
                          'Update',
                          style: sTxl1,
                        ),
                      ),
                    ),
                  )),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              left: 40.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.13,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: kSecondaryGradientColor,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  'data12',
                  style: paragraph,
                ),
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              right: 40.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.28,
                height: MediaQuery.of(context).size.height * 0.13,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: kSecondaryGradientColor,
                  shape: BoxShape.circle,

                ),
                child: const Text(
                  'data123',
                  style: paragraph,
                ),
              )),
              Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: 40.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.13,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: kSecondaryGradientColor,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  'data125',
                  style: paragraph,
                ),
              )),
        ].animate(interval: 800.ms).fade(duration: 500.ms),
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

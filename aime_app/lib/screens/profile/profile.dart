import 'package:dailyme/constants/animations/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:dailyme/constants/constants.dart';
import 'package:dailyme/constants/navBar/CustomBottomNavBar.dart';
import 'package:dailyme/screens/home/icon_btn_with_counter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  get press => null;

   final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'naME');
    _emailController = TextEditingController(text: 'widget.user.email');
    _passwordController = TextEditingController(text: 'widget.user.password');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    int _currentIndex = 1;
    return Scaffold(
      backgroundColor: kDark,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: kDark,
                expandedHeight: 400.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/bg.jpg'),
                            fit: BoxFit.cover)),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [kDark, kDark.withOpacity(0.3)])),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FadeAnimation(
                              1,
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter the name...',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the name';
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 27, 147, 163)
                                ),
                              ),
                            ),
                            FadeAnimation(
                              1,
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter the email...',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the email';
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 27, 147, 163)
                                ),
                              ),
                            ),
                            FadeAnimation(
                              1,
                              TextFormField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter the password...',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the password';
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 27, 147, 163)
                                ),
                              ),
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
                      height: 50.0,
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
              bottom: 40.0,
              right: 220.0,
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: press,
                child: IconBtnWithCounter(
                  svgSrc: Icons.camera,
                  Icolor: kPrimaryColor,
                  press: () {
                    //       Navigator.of(context).pushAndRemoveUntil(
                    // MaterialPageRoute(builder: (context) => EventList()),
                    // (route) => false,
                    // );
                  },
                ),
              )),
        ],
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

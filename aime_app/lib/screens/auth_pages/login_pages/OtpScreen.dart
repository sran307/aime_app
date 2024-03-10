import 'package:dailyme/screens/auth_pages/login_pages/KeyboardNumber.dart';
import 'package:dailyme/screens/auth_pages/login_pages/PinNumber.dart';
import 'package:dailyme/services/TokenHandler.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<String> currentPin = ["", "", "", ""];
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.transparent),
  );

  int pinIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        buildExitButton(),
        Expanded(
            child: Container(
          alignment: Alignment(0, 0.5),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            buildSecurityText(),
            SizedBox(height: 40.0),
            buildPinrow(),
          ]),
        )),
        buildNumberPad(),
      ],
    ));
  }

  buildNumberPad() {
    return Expanded(
        child: Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 32),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KeyboardNumber(
                  n: 1,
                  onPressed: () {
                    pinIndexSetup("1");
                  }),
              KeyboardNumber(
                  n: 2,
                  onPressed: () {
                    pinIndexSetup("2");
                  }),
              KeyboardNumber(
                  n: 3,
                  onPressed: () {
                    pinIndexSetup("3");
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KeyboardNumber(
                  n: 4,
                  onPressed: () {
                    pinIndexSetup("4");
                  }),
              KeyboardNumber(
                  n: 5,
                  onPressed: () {
                    pinIndexSetup("5");
                  }),
              KeyboardNumber(
                  n: 6,
                  onPressed: () {
                    pinIndexSetup("6");
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KeyboardNumber(
                  n: 7,
                  onPressed: () {
                    pinIndexSetup("7");
                  }),
              KeyboardNumber(
                  n: 8,
                  onPressed: () {
                    pinIndexSetup("8");
                  }),
              KeyboardNumber(
                  n: 9,
                  onPressed: () {
                    pinIndexSetup("9");
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 60.0,
                child: MaterialButton(
                  onPressed: null,
                  child: SizedBox(),
                ),
              ),
              KeyboardNumber(
                  n: 0,
                  onPressed: () {
                    pinIndexSetup("0");
                  }),
              Container(
                width: 60,
                child: MaterialButton(
                    height: 60.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0)),
                    onPressed: () {
                      clearPin();
                    },
                    child: Image.asset("assets/images/back.jpg")),
              ),
            ],
          ),
        ]),
      ),
    ));
  }

  clearPin() {
    if (pinIndex == 0) {
      pinIndex = 0;
    } else if (pinIndex == 4) {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    } else {
      setPin(pinIndex, "");
      currentPin[pinIndex - 1] = "";
      pinIndex--;
    }
  }

  pinIndexSetup(String text) {
    if (pinIndex == 0) {
      pinIndex = 1;
    } else if (pinIndex < 4) {
      pinIndex++;
    }
    setPin(pinIndex, text);
    currentPin[pinIndex - 1] = text;
    String strPin = "";
    currentPin.forEach((e) {
      strPin += e;
    });
    if (pinIndex == 4) {
      TokenHandler tokenHandler = TokenHandler(context);
      print(strPin);
      tokenHandler.loadKey(strPin);
    }
  }

  setPin(int n, String text) {
    switch (n) {
      case 1:
        pinOneController.text = text;
        break;
      case 2:
        pinTwoController.text = text;
        break;
      case 3:
        pinThreeController.text = text;
        break;
      case 4:
        pinFourController.text = text;
        break;
    }
  }

  buildPinrow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinOneController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinTwoController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinThreeController,
        ),
        PinNumber(
          outlineInputBorder: outlineInputBorder,
          textEditingController: pinFourController,
        )
      ],
    );
  }

  buildSecurityText() {
    return Text('data');
  }

  buildExitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(3.0),
          child: MaterialButton(
            onPressed: () {},
            height: 50.0,
            minWidth: 50.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
            child: Icon(Icons.clear, color: Colors.white),
          ),
        )
      ],
    );
  }
}

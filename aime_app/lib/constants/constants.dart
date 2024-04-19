import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromARGB(255, 24, 140, 148);
const kSuccessColor = Color.fromARGB(255, 26, 172, 152);
const kPrimaryLightColor = Color.fromARGB(255, 156, 223, 208);
const kFadeColor = Color.fromARGB(30, 156, 156, 161);
const kDark = Color.fromARGB(255, 0, 0, 0);
const kLight = Color.fromARGB(255, 255, 255, 255);
const barColor = Color.fromARGB(255, 241, 206, 160);
const homeColor = Color.fromARGB(255, 255, 255, 255);
const iconColor = Color.fromARGB(255, 117, 82, 6);
const iconColor1 = Color.fromARGB(255, 241, 175, 33);
const bg1 = Color.fromARGB(255, 241, 215, 157);

const sTxl1 = TextStyle(
  color: kLight,
  fontWeight: FontWeight.bold,
);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromARGB(255, 62, 255, 229),
    Color.fromARGB(255, 21, 144, 153)
  ],
);
const kSuccessGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromARGB(255, 29, 199, 162),
    Color.fromARGB(255, 21, 153, 109)
  ],
);

const kSecondaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromARGB(255, 247, 189, 115),
    Color.fromARGB(255, 255, 214, 132)
  ],
);

const kSecondaryColor = Color(0xFF979797);
const kTextColor = Colors.black;

const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 16),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: kTextColor),
  );
}

const mainHeading = TextStyle(
  color: Color.fromARGB(255, 13, 163, 168),
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.italic,
  fontSize: 18.0,
  shadows: [
    Shadow(
      color: Colors.grey,
      offset: Offset(3, 4), // Specify the offset of the shadow
      blurRadius: 3, // Specify the blur radius of the shadow
    ),
  ],
);

const subHeading = TextStyle(
  color: Color.fromARGB(255, 168, 132, 13),
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.normal,
  decoration: TextDecoration.underline,
  decorationThickness: 0.5,
  fontSize: 18.0,
  shadows: [
    Shadow(
      color: Colors.grey,
      offset: Offset(3, 5), // Specify the offset of the shadow
      blurRadius: 2, // Specify the blur radius of the shadow
    ),
  ],
);

const formHeading = TextStyle(
  color: Color.fromARGB(255, 168, 132, 13),
  fontWeight: FontWeight.bold,
  decorationThickness: 0.5,  
  fontSize: 18.0,
  shadows: [
    Shadow(
      color: Colors.grey,
      offset: Offset(3, 5), // Specify the offset of the shadow
      blurRadius: 2, // Specify the blur radius of the shadow
    ),
  ],
);

const paragraph = TextStyle(
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 1, 51, 43),
  fontSize: 16.0,
);


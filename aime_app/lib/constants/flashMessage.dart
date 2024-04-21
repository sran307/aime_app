import 'package:flutter/material.dart';
import 'package:dailyme/constants/constants.dart';

class FlashMessage {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showMessage(BuildContext context, String message, status) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    if (scaffoldMessenger != null) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          backgroundColor: status == 200 ? kSuccessColor : kDangerColor,
          content: Text(message, style: TextStyle(
            color: Colors.white,
            )
            ),
          duration: Duration(seconds: 3),
          // behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      print("Error: ScaffoldMessenger not available");
    }
  }
}

// import 'package:flutter/material.dart';

// class FlashMessage {
//   static void showMessage(BuildContext context, String message) {
//     final snackBar = SnackBar(
//       content: Padding(
//         padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8.0), // Adjust top padding
//         child: Text(
//           message,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 16.0,
//           ),
//         ),
//       ),
//       backgroundColor: Colors.blue, // Adjust color as needed
//       behavior: SnackBarBehavior.floating, // Show SnackBar at the top
//       duration: Duration(seconds: 3), // Adjust duration as needed
//     );

//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }


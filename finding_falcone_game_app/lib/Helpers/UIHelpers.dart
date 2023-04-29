import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIHelpers {
  UIHelpers._createInstance();

  static final UIHelpers instance = UIHelpers._createInstance();
  
  closeLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  showLoadingDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            width: 10.0,
          ),
          Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
  sizedBoxGenerator(double height) {
    return SizedBox(
      height: height,
    );
  }
}
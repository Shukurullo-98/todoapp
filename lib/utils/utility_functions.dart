import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilityFunctions {
  static getMyToast({required String message}) =>
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade300,
        textColor: Colors.black,
        fontSize: 14
      );


  static void filedFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

}

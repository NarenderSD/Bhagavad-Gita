import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

TextStyle titleTSB(
    {double fs = 18,
    FontWeight fw = FontWeight.w500,
    Color co = Colors.black}) {
  return TextStyle(fontSize: fs, fontWeight: fw, color: co);
}

TextStyle summaryTSB(
    {double fs = 18,
    FontWeight fw = FontWeight.w500,
    Color co = Colors.black}) {
  return TextStyle(fontSize: fs, fontWeight: fw, color: co);
}

myToast({required String msg, bkgColor = Colors.red, txtColor = Colors.white}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: bkgColor,
      textColor: txtColor,
      fontSize: 16.0);
}

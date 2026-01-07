import 'package:abo_sadah/core/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  //* Show Success Toast
  static void showSuccessToast(String message) {
    closeToast();
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green.shade900,
      textColor: ThemeColors.background,
      fontSize: 16.0,
    );
  }

  //* Show Error Toast
  static void showErrorToast(String message) {
    closeToast();
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red.shade900,
      textColor: ThemeColors.background,
      fontSize: 16.0,
    );
  }

  //* Close Toast
  static void closeToast() => Fluttertoast.cancel();
}

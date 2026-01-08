import 'dart:io';

import 'package:abo_sadah/core/functions/toast_helper.dart';
import 'package:flutter/material.dart';

void showMessage(BuildContext context, String msg, {bool isError = false}) {
  if (Platform.isAndroid || Platform.isIOS) {
    if (isError) {
      ToastHelper.showErrorToast(msg);
    } else {
      ToastHelper.showSuccessToast(msg);
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }
}

import 'package:abo_sadah/core/functions/toast_helper.dart';
import 'package:flutter/material.dart';

void showMessage(BuildContext context, String msg, {bool isError = false}) {
  if (isError) {
    ToastHelper.showErrorToast(msg);
  } else {
    ToastHelper.showSuccessToast(msg);
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syscraft_task/app_locale/lang_key.dart';

class Utility {
  static void showToast({required String? msg}) {
    if (msg?.isNotEmpty ?? false) {
      Fluttertoast.showToast(
          msg: msg!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16);
    }
  }

  static void commonDatePicker({
    required BuildContext context,
    required DateTime selectedDate,
    required Function(DateTime selectDate) onDateSelection,
    DateTime? minDate,
    DateTime? maxDate,
  }) {
    showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: minDate ?? DateTime(1970),
      lastDate: maxDate ?? DateTime.now(),
      helpText: LangKey.selectDate,
      cancelText: LangKey.cancel,
      confirmText: LangKey.ok,
    ).then((pickedDate) {
      if (pickedDate != null) {
        onDateSelection(pickedDate);
      }
    });
  }

  static bool isEmail(String s) => hasMatch(s,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static Future<bool> checkNetwork() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}

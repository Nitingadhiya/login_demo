import 'package:login_demo/app_extensions.dart';
import 'package:login_demo/common/assets/index.dart';
import 'package:login_demo/common/theme/index.dart';
import 'package:login_demo/controllers/common/app_controller.dart';
import 'package:login_demo/utilities/general_utils.dart';
import 'package:login_demo/widgets/common/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

var appCtrl = Get.isRegistered<AppController>() ? Get.find<AppController>() : Get.put(AppController());

snackBar(message, {context, duration, type = 'error'}) {
  Color bgColor;
  Color txtColor;

  if (type == 'error') {
    bgColor = Get.isDarkMode ? const Color(0xFF862222) : appCtrl.appTheme.error;
    txtColor = Colors.white;
  } else if (type == 'info') {
    bgColor = Get.isDarkMode ? Colors.white : Colors.black;
    txtColor = Get.isDarkMode ? Colors.black : Colors.white;
  } else {
    bgColor = appCtrl.appTheme.lightGray;
    txtColor = Get.isDarkMode ? Colors.white : Colors.black;
  }

  final snackBar = SnackBar(
    backgroundColor: bgColor,
    elevation: 0,
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(message, style: AppCss.h4.copyWith(color: txtColor), textAlign: TextAlign.center),
    ),
    duration: Duration(milliseconds: duration == 'short' ? 1000 : (duration == 'long' ? 2000 : 1500)),
    padding: EdgeInsets.zero,
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context ?? Get.context).clearSnackBars();
  ScaffoldMessenger.of(context ?? Get.context).showSnackBar(snackBar);
}
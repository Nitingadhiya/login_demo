import 'dart:io';

import 'package:login_demo/config.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:login_demo/utilities/snack_and_dialogs_utils.dart';
import 'package:login_demo/utilities/storage_utils.dart';

import 'general_utils.dart';

checkApiValidationError(data) {
  dynamic error = data['errors'];
  if (error != null) {
    List keys = error.keys.toList();
    if (keys.isNotEmpty) {
      var msg = '';
      for (int i = 0; i < keys.length; i++) {
        String key = keys[i].toString();
        if (i > 0) msg += '\n';
        msg += error[key][0].toString();
      }
      snackBar(msg, duration: 'long');
    } else {
      snackBar(data['message'], duration: 'long');
    }
  } else {
    snackBar(data['message'] ?? '', duration: 'long');
  }
}

apiExceptionMethod(controllerName, e) async {
  hideLoading();
  snackBar('something went wrong. Try again after some time');
}

Future<bool> isNetworkConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity(); //Check For Wifi or Mobile data is ON/OFF
  if (connectivityResult == ConnectivityResult.none) {
    snackBar("Couldn't connect to the internet", duration: 'long', type: 'info');
    return false;
  } else {
    final result = await InternetAddress.lookup('google.com'); //Check For Internet Connection
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

void listenNetworkConnectivity() {
  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    if (result != ConnectivityResult.none) {

    } else {
      snackBar("Couldn't connect to the internet", duration: 3000, type: 'info');
    }
  });
}
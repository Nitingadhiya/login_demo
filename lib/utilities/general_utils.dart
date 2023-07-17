import 'dart:convert';
import 'dart:developer';
import 'dart:math' show Random;
import 'dart:math' as math;

import 'package:login_demo/config.dart';
import 'package:flutter/foundation.dart';
import 'package:login_demo/utilities/storage_utils.dart';

var loadingCtrl = Get.find<AppController>();

//var permGranted = "granted";
//var permDenied = "denied";
//var permUnknown = "unknown";
//var permProvisional = "provisional";
//var permissionGranted = '';

printLog(val, {type}) {
  if (!kDebugMode) return;

  // var date = toDateString(DateTime.now(), 'dd-MM-yyyy hh:mm:ss:ms aa');
  var logType = type ?? 'INFO';
  var spaceBeforeData = "\n${' ' * 5}";
  var spaceAfterData = "\n";

  log("| $logType | $spaceBeforeData $val $spaceAfterData");
}

jsonGet(json, String path, defaultValue) {
  try {
    List pathSplitter = path.split(".");

    /// <String,dynamic> || String
    dynamic returnValue;

    json.forEach((key, value) {
      var currentPatten = pathSplitter[0];
      int index = 0;

      if (currentPatten.contains('[') && currentPatten.contains(']')) {
        int index1 = currentPatten.indexOf('[');
        int index2 = currentPatten.indexOf(']');

        index = int.parse(currentPatten.substring(index1 + 1, index2));
        currentPatten = currentPatten.substring(0, index1);
      }

      if (key == currentPatten) {
        if (pathSplitter.length == 1) {
          returnValue = value;
          return;
        }

        pathSplitter.remove(pathSplitter[0]);

        if (value == null) {
          returnValue = defaultValue;
          return;
        }
        try {
          try {
            value = value.toJson();
          } catch (error) {
            // handle error
          }

          try {
            if (value is List) {
              value = value[index];
            }
          } catch (error) {
            // handle error
          }

          returnValue = jsonGet(value, pathSplitter.join("."), defaultValue);
        } catch (error) {
          returnValue = defaultValue;
        }
        return;
      }
    });

    return returnValue ?? defaultValue;
  } on Exception {
    // TODO
    return defaultValue;
  } catch (e) {
    return defaultValue;
  }

  //ex : helper.jsonGet(jobDetailCtrl.jobData, "salary_range", null);
  //ex : helper.jsonGet(jobDetailCtrl.jobData, "salary_range.from", '');
  //ex : helper.jsonGet(jobDetailCtrl.jobData, "salary_range.from.amount_gross", 0);
  //ex : helper.jsonGet(jobDetailCtrl.jobData, "salary_range[0].from.amount_gross", 'null');
  //ex : helper.jsonGet(jobDetailCtrl.jobData, "salary_range[0].from[1].amount_gross", null);
}

void showLoading() {
  return loadingCtrl.showLoading();
}

void hideLoading() {
  return loadingCtrl.hideLoading();
}

List arrayFilter(List val) {
  if (val.isNotEmpty) {
    List newArray = [];
    for (int i = 0; i < val.length; i++) {
      if (val[i] != null) {
        newArray.add(val[i]);
      }
    }
    return newArray;
  } else {
    return [];
  }
}

bool isNullOrBlank(dynamic val) {
  if (val is List) {
    if (val.isEmpty) {
      return true;
    } else {
      return false;
    }
  } else {
    if (val == null || val == '' || val.toString().isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

Future<Map<String, dynamic>>? getParams(Uri uri) async {
  String? magicLink = uri.queryParameters['l'];
  Map<String, dynamic> data;
  if (magicLink != null) {
    data = {'linkType': 'magicLink'};
    Uri baseLink = Uri.parse(magicLink);
    baseLink.queryParameters.forEach((k, v) {
      data['token'] = v;
    });
  } else {
    data = {'linkType': 'screen'};
    var args = {};
    uri.queryParameters.forEach((k, v) {
      if (k == 'screen') {
        data['screen'] = v;
      } else {
        args[k] = v;
      }
    });
    data['args'] = args;
  }

  return data;
}


String getRandomString(length) {
  const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();

  return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}

String base64Encoded(credentials) {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String encoded = stringToBase64.encode(credentials);

  return encoded;
}

String base64Decoded(credentials) {
  credentials = base64.normalize(credentials);
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String decoded = stringToBase64.decode(credentials);

  return decoded;
}

//#region Date

//#endregion

//#region To
List toList(val) {
  if (val != null && val is List) {
    return val;
  } else {
    return [];
  }
}

String toString(val) {
  if (val != null) {
    return val.toString();
  } else {
    return '';
  }
}
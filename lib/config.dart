//ext

import 'package:get/get.dart';

import 'controllers/common/app_controller.dart';

export 'app_extensions.dart';
//common
export 'common/assets/index.dart';
export 'common/constants/index.dart';
export 'common/theme/index.dart';
//ctrl
export 'controllers/common/app_controller.dart';
export 'routes/index.dart';
//Flutter Core Package
export 'package:flutter/material.dart';
export 'package:get/get.dart';

var appCtrl = Get.isRegistered<AppController>() ? Get.find<AppController>() : Get.put(AppController());
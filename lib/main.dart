import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_demo/routes/index.dart';
import 'package:login_demo/views/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        double scaleFactor = 1;
        if (data.textScaleFactor < 0.9) {
          scaleFactor = data.textScaleFactor * 1.05;
        } else if (data.textScaleFactor > 1.2) {
          scaleFactor = 1.2;
        } else {
          scaleFactor = data.textScaleFactor;
        }

        return MediaQuery(
          data: data.copyWith(textScaleFactor: scaleFactor),
          child: child!,
        );
      },
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 100),
      debugShowCheckedModeBanner: false,
      title: "Login Demo",
      home: Login(),
      getPages: appRoute.getPages,
    );
  }
}
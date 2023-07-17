//app file
import 'package:get/get.dart';
import 'package:login_demo/routes/route_name.dart';
import 'screen_list.dart';

RouteName _routeName = RouteName();

class AppRoute {
  final List<GetPage> getPages = [
    GetPage(name: _routeName.login, page: () => Login()),
    GetPage(name: _routeName.otpVerificationNew, page: () => OtpVerificationNew()),
    GetPage(name: _routeName.home, page: () => Home()),
  ];
}
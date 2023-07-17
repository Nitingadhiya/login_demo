import 'package:get/get.dart';

import '../../common/theme/app_theme.dart';

class AppController extends GetxController {
  AppTheme _appTheme = AppTheme.fromType(ThemeType.light);
  bool _isLoading = false;
  bool isSharing = false;

  AppTheme get appTheme => _appTheme;
  bool get isLoading => _isLoading;

  @override
  void onReady() async {
    updateTheme(Get.isDarkMode ? AppTheme.fromType(ThemeType.dark) : AppTheme.fromType(ThemeType.light));
    super.onReady();
  }

  updateTheme(theme) {
    _appTheme = theme;
    update();
    Get.forceAppUpdate();
  }

  void showLoading() {
    _isLoading = true;
    update();
  }

  void hideLoading() {
    _isLoading = false;
    update();
  }
}
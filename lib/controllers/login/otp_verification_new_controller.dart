import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_demo/config.dart';

import '../../utilities/general_utils.dart';
import '../../utilities/snack_and_dialogs_utils.dart';

class OtpVerificationNewController extends GetxController {
  TextEditingController pinController = TextEditingController();
  FocusNode focusNode = FocusNode();

  String sendTo = '';
  String verificationId = '';

  @override
  onInit() {
    var args = Get.arguments;
    if (args != null) {
      sendTo = args['mobile'] ?? '';
      verificationId = args['verificationId'] ?? '';
    }
    super.onInit();
  }

  @override
  onReady() {
    focusNode.requestFocus();
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }

  updateCode(String code) async {
    try {
      showLoading();

      AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);

      FirebaseAuth.instance.signInWithCredential(credential).then((result) {
        snackBar('Success', type: 'success');
        Get.offAllNamed(routeName.home);
        hideLoading();
      }).catchError((e) {
        snackBar(e.toString());
        hideLoading();
      });
    } on Exception catch (e) {
      printLog("::: Exception : $e");
    }
  }
}
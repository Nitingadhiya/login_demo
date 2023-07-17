import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_demo/config.dart';
import '../../utilities/index.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:117233823958:android:3170838012e93413461977',
        apiKey: 'AIzaSyCBaX3ILm19nMDaoreA1wAtJGrYk7oQKwc',
        projectId: 'logindemo-a7898',
        messagingSenderId: '117233823958',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:117233823958:android:3170838012e93413461977',
        apiKey: 'AIzaSyCBaX3ILm19nMDaoreA1wAtJGrYk7oQKwc',
        projectId: 'logindemo-a7898',
        messagingSenderId: '117233823958',
      );
    }
  }
}

class LoginController extends GetxController with GetSingleTickerProviderStateMixin {
  var formKey = GlobalKey<FormState>();

  TextEditingController txtPhone = TextEditingController();

  String? phoneError;

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseConfig.platformOptions,
    );
    super.onInit();
  }

  @override
  void dispose() {
    txtPhone.dispose();
    super.dispose();
  }

  void login() async {
    showLoading();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${txtPhone.text}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        // print("verification failed");
        snackBar('Verification failed');
        hideLoading();
      },
      timeout: const Duration(seconds: 120),
      codeSent: (String verificationId, int? resendToken) {
        hideLoading();
        Get.toNamed(routeName.otpVerificationNew, arguments: {'mobile': txtPhone.text, 'verificationId': verificationId});
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        hideLoading();
      },
    );
  }
}
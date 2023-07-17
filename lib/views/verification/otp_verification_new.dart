import 'package:login_demo/config.dart';
import 'package:login_demo/controllers/login/otp_verification_new_controller.dart';
import 'package:login_demo/widgets/common/custom_button.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import '../../widgets/common/app_component.dart';

// ignore: must_be_immutable
class OtpVerificationNew extends StatelessWidget {
  OtpVerificationNew({Key? key}) : super(key: key);
  var otpCtrl = Get.put(OtpVerificationNewController());

  @override
  Widget build(BuildContext context) {
    return AppComponent(
      child: Scaffold(
        backgroundColor: appCtrl.appTheme.white,
        appBar: AppBar(
          title: Center(child: Image.asset(imageAssets.bullIcon, width: 40)),
          backgroundColor: appCtrl.appTheme.primary,
          elevation: 0,
          actions: [
            // if (otpCtrl.canSkip)
            TextButton(
              key: const Key('otp_verification_skip_button'),
              child: Text(
                '',
                style: AppCss.paragraphSmall.textColor(appCtrl.appTheme.darkGray),
              ),
              onPressed: () => null,
            ),
          ],
        ),
        body: GetBuilder<OtpVerificationNewController>(
          builder: (_) => Container(
            color: appCtrl.appTheme.primary,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VSpace(Insets.i20),
                      Center(
                          child: Text(
                        'Enter OTP',
                        style: AppCss.h1.copyWith(fontSize: 30),
                        textAlign: TextAlign.center,
                      )),
                      Center(
                        child: Text(
                          'OTP has been sent to',
                          style: AppCss.paragraphSmall,
                        ),
                      ),
                      const VSpace(Sizes.s32),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const VSpace(Sizes.s8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: appCtrl.appTheme.lightGray,
                                  borderRadius: BorderRadius.circular(AppRadius.r10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(maxWidth: Get.width - 100),
                                      child: Text(
                                        '${otpCtrl.sendTo}',
                                        style: AppCss.paragraph.textColor(appCtrl.appTheme.black),
                                      ),
                                    ),
                                    //const HSpace(Sizes.s8),

                                  ],
                                ).paddingSymmetric(vertical: Insets.i8, horizontal: Insets.i16),
                              )
                            ],
                          )
                        ],
                      ),
                      const VSpace(Sizes.s40),
                      Center(
                        child: Pinput(
                          key: const Key('otp_verification_pin_put'),
                          length: 6,
                          controller: otpCtrl.pinController,
                          focusNode: otpCtrl.focusNode,
                          closeKeyboardWhenCompleted: false,
                          enableSuggestions: true,
                          keyboardType: TextInputType.number,
                          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                          listenForMultipleSmsOnAndroid: true,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          defaultPinTheme: PinTheme(
                            width: 56,
                            height: 60,
                            textStyle: AppCss.h1.textColor(appCtrl.appTheme.black),
                            decoration: BoxDecoration(
                              color: appCtrl.appTheme.lightGray,
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          onChanged: (code) {
                            if (code != null && code.length == 6) {
                              otpCtrl.updateCode(code);
                            }
                          },
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: Insets.i16),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButton(
            key: const Key('Continue'),
            // isClickable: loginCtrl.isLoading,
            title: 'Continue',
            suffixIcon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            onTap: () {
              otpCtrl.updateCode(otpCtrl.pinController.text);
              // if (loginCtrl.formKey.currentState!.validate()) {
              // loginCtrl.login();
              // }
            },
          ),
        ),
      ),
    );
  }
}
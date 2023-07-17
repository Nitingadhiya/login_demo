// ignore: must_be_immutable
import 'package:login_demo/controllers/login/login_controller.dart';
import 'package:login_demo/widgets/common/app_component.dart';

import '../../config.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_form_field.dart';

class Login extends StatelessWidget {
  var loginCtrl = Get.put(LoginController());

  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppComponent(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Image.asset(imageAssets.bullIcon, width: 40)),
          backgroundColor: appCtrl.appTheme.primary,
          elevation: 0,
        ),
        backgroundColor: appCtrl.appTheme.white,
        body: GetBuilder<LoginController>(
          builder: (_) => Container(
            color: appCtrl.appTheme.primary,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///body
                  Padding(
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
                            'Welcome \n To BullSpree',
                            style: AppCss.h1.copyWith(fontSize: 30),
                            textAlign: TextAlign.center,
                          )),
                          const VSpace(Insets.i10),
                          Center(
                              child: Text(
                            'Experiencing Stock Market \n was never this easy',
                            style: AppCss.paragraphSmall.copyWith(color: appCtrl.appTheme.darkGray),
                            textAlign: TextAlign.center,
                          )),
                          const VSpace(Sizes.s40),
                          CustomTextFormField(
                            controller: loginCtrl.txtPhone,
                            key: const Key('mobile_number'),
                            hintText: 'Mobile Number',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            padding: const EdgeInsets.all(Insets.i18),
                            errorText: loginCtrl.phoneError,
                            textCapitalization: TextCapitalization.none,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please enter some value.';
                              } else {
                                return null;
                              }
                            },
                            autofillHints: const [AutofillHints.email, AutofillHints.telephoneNumber],
                          ),
                          const VSpace(Sizes.s48),
                          const VSpace(Sizes.s25),
                        ],
                      ).paddingAll(Insets.i16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButton(
            key: const Key('login_login_button'),
            title: 'Verify OTP',
            suffixIcon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            onTap: () {
              // if (loginCtrl.formKey.currentState!.validate()) {
              loginCtrl.login();
              // }
            },
          ),
        ),
      ),
    );
  }
}
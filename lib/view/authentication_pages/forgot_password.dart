import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/constants.dart';
import 'package:job_app/constants/maxin_validator.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/view/widgets/primary_button.dart';
import 'package:job_app/view/widgets/primary_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgotPassword extends StatelessWidget with ValidationMixin {
  ForgotPassword({Key? key}) : super(key: key);
  final AuthcController authcController = Get.put(AuthcController());
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Forgot Password'),
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: Adaptive.h(10),
              ),
              PrimaryField(
                controller: authcController.forgotEmail,
                hintText: 'Email',
                isPasswordField: false,
                prefixIcon: FontAwesomeIcons.envelope,
                validator: (email) {
                  return isEmailValid(email!) ? null : 'Enter valid email';
                },
              ),
              SizedBox(
                height: Adaptive.h(10),
              ),
              Obx(
                () => authcController.ismailSend.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : PrimaryButton(
                        text: 'Submit',
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            authcController.forgotPassword();
                          }
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/constants/maxin_validator.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/view/authentication_pages/forgot_password.dart';
import 'package:job_app/view/authentication_pages/sign_up_page.dart';
import 'package:job_app/constants/constants.dart';
import 'package:job_app/view/widgets/primary_button.dart';
import 'package:job_app/view/widgets/primary_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<LoginPage> with ValidationMixin {
  // TextEditingController userNameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  AuthcController authcController = Get.put(AuthcController());

  bool isPasswordField = true;
  bool isRemeber = false;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Text(
                  'Welcome back',
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                    fontSize: Adaptive.px(32),
                    fontWeight: FontWeight.w700,
                  )),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Let’s log in. You’ve been missed!',
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                          fontSize: Adaptive.px(14),
                          fontWeight: FontWeight.w400,
                          color: Colors.black)),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                PrimaryField(
                  controller: authcController.loginEmail,
                  hintText: 'Email',
                  isPasswordField: false,
                  prefixIcon: FontAwesomeIcons.envelope,
                  validator: (email) {
                    return isEmailValid(email!) ? null : 'Enter valid email';
                  },
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                PrimaryField(
                    onTap: () {
                      setState(() {
                        isPasswordField = !isPasswordField;
                      });
                    },
                    sufixIcon: isPasswordField
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    controller: authcController.loginPassword,
                    hintText: 'Password',
                    isPasswordField: isPasswordField,
                    validator: (password) {
                      return isPasswordValid(password!)
                          ? null
                          : 'Enter password that contains minimum 8 letters';
                    },
                    prefixIcon: FontAwesomeIcons.lock),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Obx(() => authcController.isLogin.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : PrimaryButton(
                        text: 'Log In',
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            authcController.login();
                          }
                        })),
                SizedBox(
                  height: size.height * 0.01,
                ),
                forgotPasswordTile(),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * 0.40,
                      child: Divider(
                        color: lightGrey,
                      ),
                    ),
                    Text(
                      'OR',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                              fontSize: Adaptive.px(15),
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ),
                    SizedBox(
                      width: size.width * 0.40,
                      child: Divider(
                        color: lightGrey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Obx(
                  () => authcController.isGoogleSignin.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : social_mediaTile(
                          'assets/icons/google.svg', 'Log in with Google', () {
                          authcController.googleSignIN();
                        }),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                // social_mediaTile('assets/icons/logos_facebook.svg',
                //     'Log in with Facebook', () {}),
                // SizedBox(
                //   height: size.height * 0.01,
                // ),
                // social_mediaTile('assets/icons/mobile.svg',
                //     'Log in with Mobile phone', () {}),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Don't have and account? ",
                            style: GoogleFonts.plusJakartaSans(
                                textStyle: TextStyle(
                                    fontSize: Adaptive.px(12),
                                    fontWeight: FontWeight.w400,
                                    color: lightGrey)),
                          ),
                          buildClickableTextSpan(
                              text: 'Sign up',
                              onTap: () {
                                print('press');
                                Get.to(() => SignUpPage());
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextSpan buildClickableTextSpan(
      {required String text, required Function()? onTap}) {
    return TextSpan(
      text: text,
      style: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(
              fontSize: Adaptive.px(12),
              fontWeight: FontWeight.w400,
              color: primaryColor)),
      recognizer: TapGestureRecognizer()..onTap = onTap!,
    );
  }

  Row forgotPasswordTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomCheckBox(
              value: isRemeber,
              splashRadius: 2,
              shouldShowBorder: true,
              borderColor: isRemeber ? primaryColor : lightGrey,
              checkedFillColor: primaryColor,
              borderRadius: 5,
              borderWidth: 1,
              checkBoxSize: 20,
              onChanged: (val) {
                //do your stuff here
                setState(() {
                  isRemeber = val;
                });
              },
            ),
            Text(
              'Remember me',
              style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(
                      fontSize: Adaptive.px(14),
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => ForgotPassword());
          },
          child: Text(
            'Forgot password?',
            style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                    fontSize: Adaptive.px(14),
                    fontWeight: FontWeight.w400,
                    color: primaryColor)),
          ),
        ),
      ],
    );
  }

  RichText privacy_text() {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: 'By signing up, you agree to the ',
            style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                    fontSize: Adaptive.px(12),
                    fontWeight: FontWeight.w400,
                    color: lightGrey)),
          ),
          TextSpan(
            text: 'Terms of Service',
            style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                    fontSize: Adaptive.px(12),
                    fontWeight: FontWeight.w400,
                    color: primaryColor)),
          ),
          TextSpan(
            text: ' and ',
            style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                    fontSize: Adaptive.px(12),
                    fontWeight: FontWeight.w400,
                    color: lightGrey)),
          ),
          TextSpan(
            text: 'Privacy Policy.',
            style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                    fontSize: Adaptive.px(12),
                    fontWeight: FontWeight.w400,
                    color: primaryColor)),
          ),
        ],
      ),
    );
  }

  Widget social_mediaTile(String iconPath, String text, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              height: Adaptive.px(25),
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(
                      fontSize: Adaptive.px(14),
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }
}

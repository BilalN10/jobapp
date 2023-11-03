import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/constants/maxin_validator.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/constants/constants.dart';
import 'package:job_app/view/widgets/primary_button.dart';
import 'package:job_app/view/widgets/primary_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with ValidationMixin {
  // TextEditingController userNameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  bool isPasswordField = true;
  AuthcController authcController = Get.put(AuthcController());
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  backButton(),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Sign Up',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                      fontSize: Adaptive.px(32),
                      fontWeight: FontWeight.w700,
                    )),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  PrimaryField(
                    controller: authcController.userNameContoller,
                    hintText: 'Username',
                    isPasswordField: false,
                    prefixIcon: FontAwesomeIcons.user,
                    validator: (value) {
                      return isFullNameValid(value!) ? null : 'requried';
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  PrimaryField(
                    controller: authcController.emailCont,
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
                    controller: authcController.passwordCont,
                    hintText: 'Password',
                    isPasswordField: isPasswordField,
                    prefixIcon: FontAwesomeIcons.lock,
                    validator: (password) {
                      return isPasswordValid(password!)
                          ? null
                          : 'Enter password that contains minimum 8 letters';
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Obx(
                    () => authcController.isSignUp.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : PrimaryButton(
                            text: 'Sign Up',
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                authcController.userSignUp();
                              }
                            }),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  privacy_text(),
                  SizedBox(
                    height: size.height * 0.02,
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
                  social_mediaTile(
                      'assets/icons/google.svg', 'Log in with Google', () {}),
                  // SizedBox(
                  //   height: size.height * 0.01,
                  // ),
                  // social_mediaTile('assets/icons/logos_facebook.svg',
                  //     'Log in with Facebook', () {}),
                  // SizedBox(
                  //   height: size.height * 0.01,
                  // ),
                  // social_mediaTile(
                  //     'assets/icons/mobile.svg', 'Log in with Mobile', () {}),
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
                              text: 'Already have and account? ',
                              style: GoogleFonts.plusJakartaSans(
                                  textStyle: TextStyle(
                                      fontSize: Adaptive.px(12),
                                      fontWeight: FontWeight.w400,
                                      color: lightGrey)),
                            ),
                            TextSpan(
                              text: 'Sign In',
                              style: GoogleFonts.plusJakartaSans(
                                  textStyle: TextStyle(
                                      fontSize: Adaptive.px(12),
                                      fontWeight: FontWeight.w400,
                                      color: primaryColor)),
                            ),
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
      ),
    );
  }

  Widget backButton() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: SvgPicture.asset(
          'assets/icons/Back.svg',
          color: Colors.black,
        ),
      ),
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

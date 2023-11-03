import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/constants/constants.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/view/authentication_pages/login_page.dart';
import 'package:job_app/view/bottom_navbar/bottom_navbar_page.dart';
import 'package:job_app/view/widgets/primary_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({super.key});

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  SharedPreferences? prefs;
  @override
  void initState() {
    initialize().then((value) {
      if (prefs!.getString('language_code') != null) {
        Get.offAll(() => BottomNavBarPage());
      }
    });

    super.initState();
  }

  AuthcController authcController = Get.put(AuthcController());

  Future initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(7)),
        child: Center(
          child: Container(
            height: Adaptive.h(100),
            width: Adaptive.w(100),
            child: Column(
              children: [
                SizedBox(
                  height: Adaptive.h(5),
                ),
                Text(
                  'Language',
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
                ),
                Container(
                  height: Adaptive.h(30),
                  decoration: BoxDecoration(
                      // color: Colors.red,
                      image: DecorationImage(
                          image:
                              AssetImage('assets/icons/language_image.png'))),
                ),
                SizedBox(
                  height: Adaptive.h(3),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: lightGrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Suggested Languages',
                        style: GoogleFonts.plusJakartaSans(
                            textStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                    ),
                    SizedBox(
                      height: Adaptive.h(1),
                    ),
                    languageTIle('', 'English(UK)', 1),
                    Divider(
                      color: lightGrey,
                    ),
                    languageTIle('', 'Nepali', 2),
                  ]),
                ),
                // Spacer(),
                // PrimaryButton(
                //     text: 'Proceed',
                //     onPressed: () {
                //       Get.offAll(() => BottomNavBarPage());
                //     }),
                // SizedBox(
                //   height: Adaptive.h(2),
                // ),
                // TextButton(
                //   onPressed: () {
                //     Get.to(() => LoginPage());
                //   },
                //   child: Text(
                //     'Skip',
                //     style: GoogleFonts.plusJakartaSans(
                //         textStyle: TextStyle(
                //       fontSize: 16,
                //       color: primaryColor,
                //       fontWeight: FontWeight.bold,
                //     )),
                //   ),
                // ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int selectedIndex = 1;

  Widget languageTIle(String flag, String name, index) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          selectedIndex = index;
        });

        if (index == 1) {
          Get.updateLocale(const Locale('en', 'US'));
          await prefs!.setString('language_code', 'en');
          await prefs!.setString('country_code', 'US');
          authcController.fetchLanguage();
          Get.offAll(() => BottomNavBarPage());
        } else {
          Get.updateLocale(const Locale('ne', 'NP'));
          await prefs!.setString('language_code', 'ne');
          await prefs!.setString('country_code', 'NP');
          authcController.fetchLanguage();

          Get.offAll(() => BottomNavBarPage());
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                ),
                SizedBox(
                  width: Adaptive.w(3),
                ),
                Text(
                  name,
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
                )
              ],
            ),
            selectedIndex == index
                ? Icon(
                    Icons.done,
                    color: primaryColor,
                    size: Adaptive.px(20),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/constants/constants.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/view/change_language_page/change_language_page.dart';
import 'package:job_app/view/pick_file.dart';
import 'package:job_app/view/privacy_policy/privacy_policy.dart';
import 'package:job_app/view/term_and_condition/term_and_condition_page.dart';
import 'package:job_app/view/widgets/primary_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LogOutPage extends StatefulWidget {
  const LogOutPage({super.key});

  @override
  State<LogOutPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<LogOutPage> {
  AuthcController authcController = Get.put(AuthcController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: Adaptive.h(5),
            ),
            Text(
              'About',
              style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              )),
            ),
            SizedBox(
              height: Adaptive.h(3),
            ),
            const Divider(),
            itemTile('assets/icons/about_us.svg', 'Log out', () {
              authcController.signOut();
            }),
          ]),
        ),
      ),
    );
  }

  Widget itemTile(String iconPath, String text, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(iconPath),
                SizedBox(
                  width: Adaptive.w(5),
                ),
                Text(
                  text,
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
                ),
              ],
            ),
            SvgPicture.asset('assets/icons/arrow_forward.svg'),
          ],
        ),
      ),
    );
  }
}

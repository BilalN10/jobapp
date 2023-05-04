import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            itemTile('assets/icons/terms.svg', 'Terms & Condition '),
            SizedBox(
              height: Adaptive.h(2),
            ),
            const Divider(),
            itemTile('assets/icons/privacy.svg', 'Privacy Policy'),
            SizedBox(
              height: Adaptive.h(2),
            ),
            const Divider(),
            itemTile('assets/icons/about_us.svg', 'About us'),
          ]),
        ),
      ),
    );
  }

  Row itemTile(String iconPath, String text) {
    return Row(
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
    );
  }
}

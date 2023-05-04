import 'dart:ui';

import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/view/constants/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CheckBoxTile extends StatefulWidget {
  CheckBoxTile(
      {super.key,
      required this.text,
      required this.value,
      required this.onChanged});
  String text;
  bool value;
  Function(bool) onChanged;
  @override
  State<CheckBoxTile> createState() => _MyWidgetState();
}

bool myValue = false;

class _MyWidgetState extends State<CheckBoxTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckBox(
            value: widget.value,
            splashRadius: 2,
            shouldShowBorder: true,
            borderColor: primaryColor,
            checkedFillColor: primaryColor,
            borderRadius: 8,
            borderWidth: 1,
            checkBoxSize: 20,
            onChanged: widget.onChanged
            //  (val) {
            //   //do your stuff here
            //   setState(() {
            //     widget.value = val;
            //   });
            // },
            ),
        SizedBox(
          width: Adaptive.w(25),
          child: Text(
            widget.text,
            style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
              fontSize: Adaptive.px(14),
              fontWeight: FontWeight.w400,
            )),
          ),
        ),
      ],
    );
  }
}

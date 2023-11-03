import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/constants/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.text, required this.onPressed});
  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ElevatedButton(
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(
                Size(size.width * 0.9, size.height * 0.06)),
            backgroundColor: MaterialStateProperty.all<Color>(primaryColor)),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.plusJakartaSans(
              textStyle: TextStyle(
            fontSize: Adaptive.px(15),
            fontWeight: FontWeight.w500,
          )),
        ));
  }
}

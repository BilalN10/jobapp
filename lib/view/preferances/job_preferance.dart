import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/model/country_model.dart';
import 'package:job_app/constants/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DistanceTile extends StatefulWidget {
  const DistanceTile({super.key});

  @override
  State<DistanceTile> createState() => _DistanceTileState();
}

class _DistanceTileState extends State<DistanceTile> {
  bool shouldCheck = false;
  RangeValues distancevalues = RangeValues(300, 3000);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomCheckBox(
              value: shouldCheck,
              splashRadius: 2,
              shouldShowBorder: true,
              borderColor: primaryColor,
              checkedFillColor: primaryColor,
              borderRadius: 8,
              borderWidth: 1,
              checkBoxSize: 20,
              onChanged: (val) {
                //do your stuff here
                setState(() {
                  shouldCheck = val;
                });
              },
            ),
            Expanded(
              child: Theme(
                data: ThemeData(
                  sliderTheme: const SliderThemeData(
                    trackHeight: 0.1, // set the track height to 8.0
                    thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius:
                            5), // optional: change the thumb size
                    overlayShape: RoundSliderOverlayShape(
                      overlayRadius: 10,
                    ), // optional: change the overlay size
                  ),
                ),
                child: RangeSlider(
                  activeColor: primaryColor,
                  inactiveColor: primaryColor,
                  values: distancevalues,
                  min: 300,
                  max: 3000,
                  onChanged: (values) {
                    setState(() {
                      distancevalues = values;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Adaptive.h(1.5),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: lightGrey),
              ),
              child: Text("Min: ${distancevalues.start.toStringAsFixed(2)} ",
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                    fontSize: Adaptive.px(16),
                    fontWeight: FontWeight.w600,
                  ))),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: lightGrey),
              ),
              child: Text("Min: ${distancevalues.end.toStringAsFixed(2)} ",
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                    fontSize: Adaptive.px(16),
                    fontWeight: FontWeight.w600,
                  ))),
            ),
          ],
        ),
      ],
    );
    ;
  }
}

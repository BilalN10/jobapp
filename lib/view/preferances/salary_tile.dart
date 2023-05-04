import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/controller/job_controller.dart';
import 'package:job_app/view/constants/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SalaryTile extends StatefulWidget {
  const SalaryTile({super.key});

  @override
  State<SalaryTile> createState() => _SalaryTileState();
}

class _SalaryTileState extends State<SalaryTile> {
  RangeValues _values = RangeValues(0.0, 300000);
  JobController jobController = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: ThemeData(
            sliderTheme: const SliderThemeData(
              trackHeight: 1, // set the track height to 8.0
              thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 12.0), // optional: change the thumb size
              overlayShape: RoundSliderOverlayShape(
                overlayRadius: 24.0,
              ), // optional: change the overlay size
            ),
          ),
          child: RangeSlider(
            activeColor: primaryColor,
            values: _values,
            min: 0.0,
            max: 300000,
            onChanged: (values) {
              setState(() {
                _values = values;
                jobController.minSalary = _values.start;
                jobController.maxSalary = _values.end;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("NPR ${_values.start.toStringAsFixed(2)} ",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                        fontSize: Adaptive.px(12),
                        fontWeight: FontWeight.w400,
                        color: primaryColor))),
            Text("NPR ${_values.end.toStringAsFixed(2)}",
                style: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                        fontSize: Adaptive.px(12),
                        fontWeight: FontWeight.w400,
                        color: primaryColor))),
          ],
        ),
      ],
    );
  }
}

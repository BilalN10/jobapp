import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/controller/job_controller.dart';
import 'package:job_app/view/constants/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SeeMore extends StatelessWidget {
  SeeMore({super.key});
  JobController jobController = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        jobController.showMoreJobType.value =
            !jobController.showMoreJobType.value;
      },
      child: Obx(
        () => Text(
          jobController.showMoreJobType.value ? 'See less' : 'See more',
          style: GoogleFonts.plusJakartaSans(
              textStyle: TextStyle(
                  fontSize: Adaptive.px(15),
                  fontWeight: FontWeight.w600,
                  color: primaryColor)),
        ),
      ),
    );
  }
}

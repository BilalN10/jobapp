import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/constants/constants.dart';
import 'package:job_app/controller/country_controller.dart';
import 'package:job_app/controller/job_controller.dart';
import 'package:job_app/model/country_model.dart';
import 'package:job_app/model/job_model.dart';
import 'package:job_app/view/home_page/details/job_list_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SavedJobs extends StatefulWidget {
  const SavedJobs({
    super.key,
  });

  @override
  State<SavedJobs> createState() => _CountryJobsState();
}

class _CountryJobsState extends State<SavedJobs> {
  JobController jobController = Get.put(JobController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Adaptive.w(5), vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      jobController.selectedBottomTab.value = 0;
                    },
                    child: SvgPicture.asset(
                      'assets/icons/Back.svg',
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'My Jobs',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    )),
                  ),
                  SizedBox()
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: Adaptive.w(90),
              height: Adaptive.h(6),
              decoration: BoxDecoration(
                color: lightGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    tabTile('Saved job', 1),
                    tabTile('Applied job', 2)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            selectedTab == 1
                ? GetX<JobController>(
                    init: jobController,
                    builder: (cont) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: cont.getSavedJobsList.length + 1,
                            itemBuilder: (context, index) {
                              if (index == cont.getSavedJobsList.length) {
                                print(
                                    'save job ${cont.getSavedJobsList.length}');
                                return SizedBox(
                                  height: 50,
                                );
                              }
                              return JobListTile(
                                  isSavedJObs: true,
                                  jObsModel: cont.getSavedJobsList[index]);
                            }),
                      );
                    })
                : SizedBox()
          ],
        ),
      ),
    );
  }

  int selectedTab = 1;

  Widget tabTile(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: Adaptive.h(6),
        width: Adaptive.w(43),
        decoration: BoxDecoration(
            color: selectedTab == index ? Colors.white : null,
            borderRadius: BorderRadius.circular(10),
            boxShadow: selectedTab == index
                ? [BoxShadow(color: Colors.black12, blurRadius: 10)]
                : null),
        child: Text(
          title,
          style: GoogleFonts.plusJakartaSans(
              textStyle: TextStyle(
            color: selectedTab == index ? primaryColor : null,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          )),
        ),
      ),
    );
  }
}

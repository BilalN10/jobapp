import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/controller/job_controller.dart';
import 'package:job_app/view/constants/constants.dart';
import 'package:job_app/view/home_page/couser_slider.dart';
import 'package:job_app/view/home_page/details/detail_page.dart';
import 'package:job_app/view/home_page/details/job_list_page.dart';
import 'package:job_app/view/preferances/preferances_page.dart';
import 'package:job_app/view/profile/profile_page.dart';
import 'package:job_app/view/widgets/search_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    jobController.isfilter.value = false;
    jobController.scrollController.addListener(() {
      if (jobController.scrollController.position.pixels ==
          jobController.scrollController.position.maxScrollExtent) {
        // If the user has reached the bottom of the list, load more items
        if (!jobController.loading && jobController.hasMoreItems) {
          Get.put(JobController()).pageNumber++;
          Get.put(JobController()).loading = true;
          Get.put(JobController()).loadMoreItems();
          Get.put(JobController()).update();
        }
      }
    });
  }

  JobController jobController = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/icons/Profile.png'),
                          ),
                          SizedBox(
                            width: Adaptive.w(3),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, Welcome Back!',
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                              ),
                              Text(
                                'Find your dream job',
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff78828A),
                                  fontWeight: FontWeight.w400,
                                )),
                              )
                            ],
                          )
                        ],
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.to(() => const ProfilePage());
                          },
                          child: SvgPicture.asset('assets/icons/menu.svg'))
                    ],
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(2.5),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SearchInputField(
                    searchController: textEditingController,
                    hintText: 'Search...',
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Recent Jobs',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                Obx(
                  () => jobController.isfilter.value
                      ? GetBuilder<JobController>(
                          init: Get.put(JobController()),
                          builder: (cont) {
                            return SizedBox(
                              height: Adaptive.h(70),
                              child: ListView.builder(
                                  itemCount: cont.filterJob.length,
                                  itemBuilder: (context, index) {
                                    print('uess');
                                    print(
                                        'filteerrr length is ${cont.filterJob.length}');
                                    return JobListTile(
                                        jObsModel: cont.filterJob[index]);
                                  }),
                            );
                          })
                      : GetBuilder<JobController>(
                          init: Get.put(JobController()),
                          builder: (cont) {
                            return SizedBox(
                              height: Adaptive.h(63),
                              child: ListView.builder(
                                // shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemCount: cont.jobsList.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  print(
                                      'job length is ${cont.jobsList.length} ');

                                  print('job length is ${cont.isfilter} ');

                                  if (index == cont.jobsList.length) {
                                    // If the index is equal to the length of the items list,
                                    // then we are at the end of the list and we need to load more items
                                    if (cont.loading || !cont.hasMoreItems) {
                                      // If we are already loading more items or there are no more items to load, return a loading spinner

                                      if (cont.loading && cont.hasMoreItems) {
                                        cont.loadMoreItems();
                                        return const Center(
                                            child: CircularProgressIndicator(
                                          color: Colors.red,
                                        ));
                                      } else {
                                        return const SizedBox();
                                      }
                                    } else {
                                      cont.pageNumber++;
                                      cont.loading = true;
                                      cont.loadMoreItems();

                                      if (cont.jobsList.isEmpty) {
                                        return SizedBox();
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                          color: Colors.green,
                                        ));
                                      }
                                    }
                                  } else if (index == 0) {
                                    return Column(
                                      children: [
                                        const CarouselSliderWidget(),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                        JobListTile(
                                            jObsModel: cont.jobsList[index])
                                      ],
                                    );
                                  } else {
                                    //  jobid = jobsList[jobsList.length].jobId!;

                                    // Otherwise, return a JobListTile widget for the item
                                    return JobListTile(
                                        jObsModel:
                                            jobController.jobsList[index]);
                                  }
                                },
                                controller: jobController.scrollController,
                              ),
                            );
                          }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

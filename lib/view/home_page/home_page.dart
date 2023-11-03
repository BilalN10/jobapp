import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/controller/job_controller.dart';
import 'package:job_app/constants/constants.dart';
import 'package:job_app/model/job_model.dart';
import 'package:job_app/view/home_page/couser_slider.dart';
import 'package:job_app/view/home_page/details/detail_page.dart';
import 'package:job_app/view/home_page/details/job_list_page.dart';
import 'package:job_app/view/preferances/preferances_page.dart';
import 'package:job_app/view/menu/menu_page.dart';
import 'package:job_app/view/share_job_detail/share_job_detail.dart';
import 'package:job_app/view/widgets/search_field.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  AuthcController authcController = Get.put(AuthcController());
  @override
  void initState() {
    if (authcController.firebaseUser.value != null) {
      authcController.getData();
    }
    handleInitialLink();
    jobController.isfilter.value = false;
    // jobController.scrollController.addListener(() {
    //   if (jobController.scrollController.position.pixels ==
    //       jobController.scrollController.position.maxScrollExtent) {
    //     // If the user has reached the bottom of the list, load more items
    //     if (!jobController.loading && jobController.hasMoreItems) {
    //       Get.put(JobController()).pageNumber++;
    //       Get.put(JobController()).loading = true;
    //       Get.put(JobController()).loadMoreItems();
    //       Get.put(JobController()).update();
    //     }
    //   }
    // });
  }

  JobController jobController = Get.put(JobController());

  int calculateExpiryDate(String expiryDate) {
    DateTime deadlineDate;

    try {
      deadlineDate = DateTime.parse(expiryDate);
    } catch (e) {
      DateFormat format = DateFormat('dd MMM, yyyy');
      deadlineDate = format.parse(expiryDate);
    }

// Get today's date
    DateTime now = DateTime.now();

// Calculate the difference between the two dates
    Duration difference = deadlineDate.difference(now);

    return difference.inDays;
  }

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> handleInitialLink() async {
    final PendingDynamicLinkData? initialLinkData =
        await dynamicLinks.getInitialLink();
    if (initialLinkData != null) {
      final Uri deepLink = initialLinkData.link;
      final queryParams = deepLink.queryParameters;
      if (queryParams.isNotEmpty) {
        log('query param is $queryParams');
        Get.to(() => ShareJobDetail(JobId: queryParams['id']!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Container(
              height: Adaptive.h(87),
              width: Adaptive.w(100),
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
                            Obx(
                              () => authcController.getUserData.email == null ||
                                      authcController.firebaseUser.value == null
                                  ? GestureDetector(
                                      onTap: () {
                                        jobController.selectedBottomTab.value =
                                            4;
                                      },
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/icons/Profile.png'),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        jobController.selectedBottomTab.value =
                                            4;
                                      },
                                      child: authcController.getUserData
                                              .profilePic!.isNotEmpty
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  authcController
                                                      .getUserData.profilePic!),
                                            )
                                          : CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/icons/Profile.png'),
                                            ),
                                    ),
                            ),
                            SizedBox(
                              width: Adaptive.w(3),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'welcome'.tr,
                                  style: GoogleFonts.plusJakartaSans(
                                      textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                                Text(
                                  'find_your_job'.tr,
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
                              Get.to(() => const MenuPage());
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
                      hintText: 'search'.tr,
                    ),
                  ),
                  SizedBox(
                    height: Adaptive.h(2),
                  ),
                  Obx(
                    () => jobController.isfilter.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'Your Search Result :',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: primaryColor),
                            ),
                          )
                        : SizedBox(),
                  ),
                  SizedBox(
                    height: Adaptive.h(2),
                  ),
                  Obx(
                    () => jobController.isfilter.value
                        ? GetBuilder<JobController>(
                            init: Get.put(JobController()),
                            builder: (cont) {
                              return cont.filterJob.isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: Adaptive.h(30),
                                          ),
                                          Text(
                                            'No result found',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      //height: Adaptive.h(67),
                                      child: ListView.builder(
                                          itemCount: cont.filterJob.length + 1,
                                          itemBuilder: (context, index) {
                                            if (index ==
                                                cont.filterJob.length) {
                                              return SizedBox(
                                                height: 50,
                                              );
                                            }
                                            return calculateExpiryDate(cont
                                                        .filterJob[index]
                                                        .deadlineAd!
                                                        .toString()) <
                                                    0
                                                ? const SizedBox()
                                                : JobListTile(
                                                    isSavedJObs: false,
                                                    jObsModel:
                                                        cont.filterJob[index]);
                                          }),
                                    );
                            })
                        : Expanded(
                            child: Scrollbar(
                              isAlwaysShown: true,
                              child: PaginateFirestore(
                                initialLoader: CircularProgressIndicator(),
                                itemBuilderType: PaginateBuilderType
                                    .listView, //Change types accordingly
                                itemBuilder:
                                    (context, documentSnapshots, index) {
                                  if (documentSnapshots[index].exists) {
                                    print(
                                        'last index is ${documentSnapshots.last}');
                                    final data =
                                        documentSnapshots[index].data() as Map?;
                                    JObsModel jObsModel =
                                        JObsModel.fromFirestore(data!);
                                    if (calculateExpiryDate(
                                            jObsModel.deadlineAd!.toString()) <
                                        0) {
                                      jobController.expiredJObs(jObsModel);
                                      return SizedBox();
                                      // JobListTile(
                                      //     isSavedJObs: false,
                                      //     jObsModel: jObsModel);
                                    } else if (index == 0) {
                                      return Column(
                                        children: [
                                          const CarouselSliderWidget(),
                                          SizedBox(
                                            height: Adaptive.h(2),
                                          ),
                                          JobListTile(
                                              isSavedJObs: false,
                                              jObsModel: jObsModel)
                                        ],
                                      );
                                    } else if (index ==
                                        documentSnapshots.last) {
                                      return Container(
                                          height: 400,
                                          child: Text('LAst index'));
                                    } else {
                                      return JobListTile(
                                          isSavedJObs: false,
                                          jObsModel: jObsModel);
                                    }
                                  } else {
                                    return Text('not found');
                                  }
                                },
                                bottomLoader: Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                ),
                                query: FirebaseFirestore.instance
                                    .collection('jobs')
                                    .orderBy('date_time', descending: false),
                                itemsPerPage: 20,
                                isLive: true,
                                padding: EdgeInsets.only(bottom: 50),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

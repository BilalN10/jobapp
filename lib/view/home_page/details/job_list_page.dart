import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/constants/constants.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/controller/job_controller.dart';
import 'package:job_app/model/job_model.dart';
import 'package:job_app/view/bottom_navbar/bottom_navbar_page.dart';
import 'package:job_app/view/home_page/details/detail_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobListTile extends StatefulWidget {
  JobListTile({super.key, required this.jObsModel, required this.isSavedJObs});

  final JObsModel jObsModel;
  final bool isSavedJObs;

  @override
  State<JobListTile> createState() => _JobListTileState();
}

class _JobListTileState extends State<JobListTile> {
  static const _locale = 'en';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  int calculateExpiryDate() {
    DateTime deadlineDate = DateTime.parse(widget.jObsModel.deadlineAd!);

// Get today's date
    DateTime now = DateTime.now();

// Calculate the difference between the two dates
    Duration difference = deadlineDate.difference(now);

    return difference.inDays;
  }

  AuthcController authcController = Get.put(AuthcController());
  JobController jobController = Get.put(JobController());

  @override
  void initState() {
    if (widget.jObsModel.estimatedSalary != '----') {
      String formated = widget.jObsModel.estimatedSalary!.split('.').first;

      widget.jObsModel.estimatedSalary =
          _formatNumber(formated.replaceAll(',', ''));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailPage(
              jObsModel: widget.jObsModel,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(blurRadius: 10, color: Colors.black12)
              ]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: Adaptive.h(6),
                          width: Adaptive.w(15),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SvgPicture.asset(
                              widget.jObsModel.countryFlag!,
                              fit: BoxFit.cover,
                            ),
                          )
                          // CircleAvatar(
                          //   child:
                          // )
                          ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Adaptive.w(50),
                            child: Obx(
                              () => Text(
                                authcController.languageCode == 'en'
                                    ? widget.jObsModel.headline!
                                        .replaceAll('?', '')
                                    : widget.jObsModel.headlineNepali!
                                                .replaceAll('?', '') ==
                                            '----'
                                        ? widget.jObsModel.headline!
                                            .replaceAll('?', '')
                                        : widget.jObsModel.headlineNepali!
                                            .replaceAll('?', ''),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: Adaptive.w(50),
                            child: Text(
                              widget.jObsModel.jobTitleNepali!.isNotEmpty
                                  ? "${widget.jObsModel.jobTitle!} (${widget.jObsModel.jobTitleNepali!}) "
                                  : widget.jObsModel.jobTitle!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                  textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              )),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            "रू.${widget.jObsModel.estimatedSalary!}/Month",
                            style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )),
                          ),
                        ],
                      )
                    ],
                  ),
                  GetBuilder<JobController>(
                      init: jobController,
                      builder: (cont) {
                        return widget.isSavedJObs
                            ? GestureDetector(
                                onTap: () {
                                  removeJobDialoger(context, 'Remove job',
                                      'Do you want to remove this from saved jobs?');
                                },
                                child: Icon(
                                  Icons.cancel,
                                  color: primaryColor,
                                ))
                            : GestureDetector(
                                onTap: () {
                                  if (cont.savedJobsId.contains(
                                      widget.jObsModel.jobIdentifier!)) {
                                    Get.snackbar('JOB ALREADY ADDED',
                                        'You already save this job!',
                                        colorText: Colors.white,
                                        backgroundColor: primaryColor);

                                    // ScaffoldMessenger.of(Get.context!)
                                    //     .showSnackBar(SnackBar(
                                    //   backgroundColor: primaryColor,
                                    //   content: Text('You already save this job!'
                                    //       .toUpperCase()),
                                    //   behavior: SnackBarBehavior.floating,
                                    // ));
                                  } else {
                                    if (authcController.firebaseUser.value ==
                                        null) {
                                      checkLogin(context, 'User not login',
                                          'Please login first ');
                                    } else {
                                      dialoger(
                                        context,
                                        'Save Job',
                                        'Do you want to save this job?',
                                      );
                                    }
                                  }
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/book_mark.svg',
                                  color: cont.savedJobsId.contains(
                                          widget.jObsModel.jobIdentifier!)
                                      ? primaryColor
                                      : Colors.black,
                                ),
                              );
                      })
                ],
              ),
              SizedBox(
                height: Adaptive.h(1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        size: Adaptive.px(18),
                      ),
                      Obx(
                        () => Text(
                          authcController.languageCode.value == 'en'
                              ? widget.jObsModel.country!
                              : widget.jObsModel.countryNepali!,
                          style: GoogleFonts.plusJakartaSans(
                              textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    calculateExpiryDate() < 0
                        ? 'expired'.tr
                        : calculateExpiryDate() == 0
                            ? 'expires'.tr + ': ' + 'today'.tr
                            : 'expires'.tr +
                                ': ' +
                                '  ${calculateExpiryDate()}' +
                                'days'.tr,
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: calculateExpiryDate() < 0
                                ? Colors.red
                                : Color(0xff00CC9A))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  removeJobDialoger(
    BuildContext context,
    String title,
    String subTitle,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            // insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.only(top: Adaptive.h(2)),
            // backgroundColor: const Color(0xff000000),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            //   title: const Text("Listview"),
            content: SizedBox(
              width: Adaptive.w(80),
              height: Adaptive.h(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(title,
                          style: GoogleFonts.plusJakartaSans(
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff00CC9A)))),
                      SizedBox(
                        height: Adaptive.h(3),
                      ),
                      SizedBox(
                        width: Adaptive.w(65),
                        child: Text(subTitle,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff00CC9A)))),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: Adaptive.h(5),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('NO',
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white))),
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.white,
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              jobController
                                  .removeFromSavedJobs(widget.jObsModel);
                            },
                            child: Text('Yes',
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white))),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  dialoger(
    BuildContext context,
    String title,
    String subTitle,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            // insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.only(top: Adaptive.h(2)),
            // backgroundColor: const Color(0xff000000),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            //   title: const Text("Listview"),
            content: SizedBox(
              width: Adaptive.w(80),
              height: Adaptive.h(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(title,
                          style: GoogleFonts.plusJakartaSans(
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff00CC9A)))),
                      SizedBox(
                        height: Adaptive.h(3),
                      ),
                      SizedBox(
                        width: Adaptive.w(65),
                        child: Text(subTitle,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff00CC9A)))),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: Adaptive.h(5),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('NO',
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white))),
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.white,
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              jobController.saveJOb(widget.jObsModel);
                            },
                            child: Text('Yes',
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white))),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  checkLogin(
    BuildContext context,
    String title,
    String subTitle,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            // insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.only(top: Adaptive.h(2)),
            // backgroundColor: const Color(0xff000000),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            //   title: const Text("Listview"),
            content: SizedBox(
              width: Adaptive.w(80),
              height: Adaptive.h(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(title,
                          style: GoogleFonts.plusJakartaSans(
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff00CC9A)))),
                      SizedBox(
                        height: Adaptive.h(3),
                      ),
                      SizedBox(
                        width: Adaptive.w(65),
                        child: Text(subTitle,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff00CC9A)))),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: Adaptive.h(5),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('CANCEL',
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white))),
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.white,
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                              jobController.selectedBottomTab.value = 4;
                            },
                            child: Text('LOGIN',
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white))),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

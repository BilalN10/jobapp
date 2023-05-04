import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/model/job_model.dart';
import 'package:job_app/view/home_page/details/detail_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class JobListTile extends StatefulWidget {
  JobListTile({super.key, required this.jObsModel});

  JObsModel jObsModel;

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

  @override
  void initState() {
    String formated = widget.jObsModel.estimatedSalary!.split('.').first;
    log('estimated salary is ${widget.jObsModel.estimatedSalary} , formated salary $formated');
    widget.jObsModel.estimatedSalary =
        _formatNumber(formated.replaceAll(',', ''));
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
                            child: Text(
                              widget.jObsModel.headline!.replaceAll('?', ''),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                  textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              )),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: Adaptive.w(50),
                            child: Text(
                              widget.jObsModel.jobTitleEnglish!.isNotEmpty
                                  ? "${widget.jObsModel.jobTitle!} (${widget.jObsModel.jobTitleEnglish!}) "
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
                  SvgPicture.asset(
                    'assets/icons/book_mark.svg',
                    color: Colors.black,
                  )
                ],
              ),
              SizedBox(
                height: Adaptive.h(5),
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
                      Text(
                        widget.jObsModel.country!,
                        style: GoogleFonts.plusJakartaSans(
                            textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
                      ),
                    ],
                  ),
                  Text(
                    calculateExpiryDate() < 0
                        ? 'Expired'
                        : calculateExpiryDate() == 0
                            ? 'Expires:Today'
                            : 'Expires: ${calculateExpiryDate()} days',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff00CC9A))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

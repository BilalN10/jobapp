import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/model/job_model.dart';
import 'package:job_app/view/agent_detail/agent_detail.dart';
import 'package:job_app/view/constants/constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  DetailPage({super.key, required this.jObsModel});
  JObsModel jObsModel;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  void launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  launchCaller(String phoneNumber) async {
    if (await canLaunch("tel:$phoneNumber")) {
      await launch("tel:$phoneNumber");
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  static const _locale = 'en';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  Widget headerImage() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: Adaptive.px(50),
        width: Adaptive.px(40),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: primaryColor.withOpacity(0.7)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            'assets/icons/Back.svg',
            color: Colors.white,
          ),
        ),
      ),
    );
  }

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
    widget.jObsModel.estimatedSalary =
        _formatNumber(widget.jObsModel.estimatedSalary!.replaceAll(',', ''));
    widget.jObsModel.sallary =
        _formatNumber(widget.jObsModel.sallary!.replaceAll(',', ''));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Adaptive.h(3),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(blurRadius: 1, color: Colors.black12),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          headerImage(),

                          Container(
                              height: Adaptive.h(6),
                              width: Adaptive.w(15),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SvgPicture.asset(
                                    widget.jObsModel.countryFlag!),
                              )), // SvgPicture.asset('assets/icons/Logo - verified.svg'),
                          SizedBox(
                            width: Adaptive.w(8),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Adaptive.h(1),
                      ),
                      SizedBox(
                        width: Adaptive.w(50),
                        child: Text(
                          widget.jObsModel.headline!.replaceAll('?', ''),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                              textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          )),
                        ),
                      ),
                      SizedBox(
                        height: Adaptive.h(2),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/phone_Icon.svg'),
                          SizedBox(
                            width: Adaptive.w(5),
                          ),
                          SvgPicture.asset('assets/icons/book_mark_cirlce.svg'),
                          SizedBox(
                            width: Adaptive.w(5),
                          ),
                          SvgPicture.asset('assets/icons/circle_icon.svg'),
                        ],
                      ),
                      SizedBox(
                        height: Adaptive.h(2),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_sharp,
                                  size: Adaptive.px(18),
                                ),
                                SizedBox(
                                  width: Adaptive.w(2),
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
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(3),
                ),

                //
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Job Details',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                InfoTile(
                    'assets/icons/salary.svg',
                    'Salary',
                    widget.jObsModel.sallary!.isNotEmpty
                        ? 'रू.${widget.jObsModel.estimatedSalary} (${widget.jObsModel.sallary} ${widget.jObsModel.currency}) '
                        : 'रू.${widget.jObsModel.estimatedSalary}'),
                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile('assets/icons/employer.svg', 'Employer',
                    '${widget.jObsModel.employerName}, ${widget.jObsModel.employerLocation} '),
                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile(
                  'assets/icons/job_type.svg',
                  'Job Type',
                  widget.jObsModel.jobTitleEnglish!.isNotEmpty
                      ? "${widget.jObsModel.jobTitle!} (${widget.jObsModel.jobTitleEnglish!})  "
                      : "${widget.jObsModel.jobTitle!}",
                ),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile('assets/icons/gender.svg', 'Gender',
                    '${widget.jObsModel.maleQuotaApproved} Males, ${widget.jObsModel.femaleQuotaApproved} Females'),
                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile(
                    'assets/icons/deadline.svg',
                    'Deadline',
                    widget.jObsModel.deadlineBS!.isNotEmpty
                        ? "${widget.jObsModel.deadlineAd!}   (${widget.jObsModel.deadlineBS!}) "
                        : "${widget.jObsModel.deadlineAd!} "),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile('assets/icons/qualification.svg', 'Qualifications',
                    widget.jObsModel.qualification!),
                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile('assets/icons/qualification.svg', 'skill type',
                    widget.jObsModel.skillType!),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile('assets/icons/lot_no.svg', 'Lot No.',
                    widget.jObsModel.lotNumber!),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile('assets/icons/deadline.svg', 'Daily Working Hours',
                    widget.jObsModel.dailyWorkHour!),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile('assets/icons/deadline.svg', 'Weekly working hours',
                    widget.jObsModel.weeklyWorkDay!),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile('assets/icons/salary.svg', 'Contract Period',
                    "${widget.jObsModel.contractPeriodinYears!} Years"),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile('assets/icons/salary.svg', 'Service Charge',
                    widget.jObsModel.totalExpense!),
                SizedBox(
                  height: Adaptive.h(3),
                ),

                //
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Other Facilites',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    )),
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                otherFacilites(widget.jObsModel.other!),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                // SizedBox(
                //   height: Adaptive.h(1),
                // ),
                // otherFacilites('8 Hours per day'),
                // SizedBox(
                //   height: Adaptive.h(1),
                // ),
                // otherFacilites('Insurance'),
                // SizedBox(
                //   height: Adaptive.h(1),
                // ),
                // otherFacilites('Free ticket'),
                // SizedBox(
                //   height: Adaptive.h(1),
                // ),
                // otherFacilites('No agent commission'),
                // SizedBox(
                //   height: Adaptive.h(2),
                // ),
                Row(
                  children: [
                    widget.jObsModel.freeVisa == 'Yes'
                        ? containerTile('Free Visa')
                        : const SizedBox(),
                    SizedBox(
                      width: Adaptive.w(2),
                    ),
                    widget.jObsModel.freeTicket == 'Yes'
                        ? containerTile('Free Ticket')
                        : const SizedBox(),
                    SizedBox(
                      width: Adaptive.w(2),
                    ),
                    widget.jObsModel.foodFacility == 'Yes'
                        ? containerTile('Free Fooding')
                        : SizedBox(),
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(5),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Manpower Details',
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                manPowerTile('assets/icons/bi_person.svg', 'Name',
                    widget.jObsModel.recruitingAgencyName!, () {
                  Get.to(() => AgentDetailPage(
                        licenseNo: widget.jObsModel.licenseNo!,
                      ));
                }),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                manPowerTile('assets/icons/location.svg', 'Location',
                    widget.jObsModel.recruitingAgencyLocation!, () {
                  launchURL(widget.jObsModel.locationGoogleMap!);
                }),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                // manPowerTile('assets/icons/call.svg', 'Phone',
                //     '${widget.jObsModel.recruitingAgencyPhone_1!},  ${widget.jObsModel.recruitingAgencyPhone_2!}',
                //     () {
                //   launchCaller(widget.jObsModel.recruitingAgencyPhone_1!);
                // }),

                Row(
                  children: [
                    SvgPicture.asset('assets/icons/call.svg'),
                    SizedBox(
                      width: Adaptive.w(5),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone',
                          style: GoogleFonts.plusJakartaSans(
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: lightGrey)),
                        ),
                        SizedBox(
                          height: Adaptive.h(0.5),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                launchCaller(
                                    widget.jObsModel.recruitingAgencyPhone_1!);
                              },
                              child: Text(
                                widget.jObsModel.recruitingAgencyPhone_1!,
                                maxLines: 2,
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                )),
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(3),
                            ),
                            GestureDetector(
                              onTap: () {
                                launchCaller(
                                    widget.jObsModel.recruitingAgencyPhone_2!);
                              },
                              child: Text(
                                widget.jObsModel.recruitingAgencyPhone_2!,
                                maxLines: 2,
                                style: GoogleFonts.plusJakartaSans(
                                    textStyle: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(3),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.jObsModel.newspaperDetailsSlogan!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                        textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                FullScreenWidget(
                    disposeLevel: DisposeLevel.High,
                    child: Container(
                      height: Adaptive.h(30),
                      width: Adaptive.w(90),
                      child: PhotoView(
                        imageProvider:
                            NetworkImage(widget.jObsModel.newsPaperImage!),
                      ),
                    )

                    // Image.network(
                    //   widget.jObsModel.newsPaperImage!,
                    // ),
                    ),

                SizedBox(
                  height: Adaptive.h(5),
                ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     'Comments',
                //     style: GoogleFonts.plusJakartaSans(
                //         textStyle: const TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.w400,
                //     )),
                //   ),
                // ),
                // SizedBox(
                //   height: Adaptive.h(3),
                // ),
                // Row(
                //   children: [
                //     SvgPicture.asset('assets/icons/edit.svg'),
                //     SizedBox(
                //       width: Adaptive.w(3),
                //     ),
                //     Text(
                //       'Write a comment',
                //       style: GoogleFonts.plusJakartaSans(
                //           textStyle: const TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w400,
                //       )),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: Adaptive.h(3),
                // ),
                // userTile('assets/icons/man_pic.png'),
                // SizedBox(
                //   height: Adaptive.h(3),
                // ),
                // userTile('assets/icons/women.png'),

                // SizedBox(
                //   height: Adaptive.h(3),
                // ),

                SizedBox(
                  height: Adaptive.h(10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column userTile(String imagePath) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(imagePath),
                ),
                SizedBox(
                  width: Adaptive.w(3),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diogo Dalot',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                    ),
                    SizedBox(
                      height: Adaptive.h(0.5),
                    ),
                    Text(
                      '2 hourse ago',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey)),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Text(
                  '23',
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
                ),
                SizedBox(
                  width: Adaptive.w(2),
                ),
                SvgPicture.asset('assets/icons/heart.svg')
              ],
            )
          ],
        ),
        SizedBox(
          height: Adaptive.h(2),
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nisl lorem pharetra eros, proin dolor felis. Consectetur adipiscing elit. Morbi nisl lorem pharetra eros, proin dolor felis.',
          style: GoogleFonts.outfit(
              textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          )),
        ),
      ],
    );
  }

  Container containerTile(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade200),
      child: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
            textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        )),
      ),
    );
  }

  Row otherFacilites(String title) {
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration:
              const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        ),
        SizedBox(
          width: Adaptive.w(3),
        ),
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
              textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          )),
        ),
      ],
    );
  }

  Row InfoTile(String iconPath, String title, String description) {
    return Row(
      children: [
        SvgPicture.asset(iconPath),
        SizedBox(
          width: Adaptive.w(5),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: lightGrey)),
            ),
            SizedBox(
              height: Adaptive.h(0.5),
            ),
            SizedBox(
              width: Adaptive.w(70),
              child: Text(
                description,
                maxLines: 2,
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget manPowerTile(
    String iconPath,
    String title,
    String description,
    Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          SizedBox(
            width: Adaptive.w(5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: lightGrey)),
              ),
              SizedBox(
                height: Adaptive.h(0.5),
              ),
              SizedBox(
                width: Adaptive.w(70),
                child: Text(
                  description,
                  maxLines: 2,
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

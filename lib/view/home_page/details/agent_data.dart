import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/controller/man_power_controller.dart';
import 'package:job_app/model/job_model.dart';
import 'package:job_app/view/constants/constants.dart';
import 'package:job_app/view/home_page/details/job_list_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgentData extends StatefulWidget {
  AgentData({super.key, required this.licenseNo});

  String licenseNo;

  @override
  State<AgentData> createState() => _AgentDetailPageState();
}

class _AgentDetailPageState extends State<AgentData> {
  ManPowerController manPowerController = Get.put(ManPowerController());

  @override
  void initState() {
    super.initState();
    log('licence init no is ${widget.licenseNo}');
    manPowerController.getManPowerDetail(widget.licenseNo);
    manPowerController.getAgentJobs(widget.licenseNo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: Adaptive.px(218),
            width: Adaptive.w(100),
            decoration: const BoxDecoration(
                //color: Colors.amber,
                image: DecorationImage(
                    image: AssetImage('assets/icons/company_image.png'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding:
                  EdgeInsets.only(left: Adaptive.w(5), bottom: Adaptive.h(10)),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerImage(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Adaptive.h(3),
          ),
          GetX<ManPowerController>(
              init: manPowerController,
              builder: (cont) {
                return cont.getManPowerData.licenseNo == null
                    ? const Center(
                        child: Text('Agent data is not available yet')

                        //   CircularProgressIndicator(
                        //   color: primaryColor,
                        // )
                        )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Adaptive.w(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'About',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.aBeeZee(
                                      textStyle: TextStyle(
                                          fontSize: Adaptive.px(18),
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                ),
                                SizedBox(
                                  height: Adaptive.h(2),
                                ),
                                Text(
                                  cont.getManPowerData.about!,
                                  style: GoogleFonts.plusJakartaSans(
                                      textStyle: TextStyle(
                                          fontSize: Adaptive.px(12),
                                          fontWeight: FontWeight.w400,
                                          color: lightGrey)),
                                ),
                                // Text(
                                //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Posuere aliquam aliquam mattis duis etiam dolor placerat. Rhoncus ut faucibus adipiscing eu, donec cras volutpat non.',
                                //   style: GoogleFonts.plusJakartaSans(
                                //       textStyle: TextStyle(
                                //           fontSize: Adaptive.px(12),
                                //           fontWeight: FontWeight.w400,
                                //           color: lightGrey)),
                                // ),
                                SizedBox(
                                  height: Adaptive.h(5),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Agent Details',
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
                                InfoTile('assets/icons/bi_person.svg', 'Name',
                                    cont.getManPowerData.manpowerName!),
                                SizedBox(
                                  height: Adaptive.h(2),
                                ),
                                InfoTile('assets/icons/location.svg',
                                    'Location', cont.getManPowerData.location!),
                                SizedBox(
                                  height: Adaptive.h(2),
                                ),
                                InfoTile('assets/icons/call.svg', 'Phone',
                                    cont.getManPowerData.phone_1!),
                                SizedBox(
                                  height: Adaptive.h(2),
                                ),
                                InfoTile(
                                    'assets/icons/licence.svg',
                                    'License Number',
                                    cont.getManPowerData.licenseNo!),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Agent Post',
                                    style: GoogleFonts.plusJakartaSans(
                                        textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GetX<ManPowerController>(
                              init: Get.put(ManPowerController()),
                              builder: (cont) {
                                return ListView.builder(
                                    itemCount: cont.getJobsList.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return JobListTile(
                                          jObsModel: cont.getJobsList[index]);
                                      //jobDetailTilte();
                                    });
                              })
                        ],
                      );
              })
        ],
      ),
    ));
  }

  Widget headerImage() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: Adaptive.px(50),
        width: Adaptive.px(50),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: primaryColor.withOpacity(0.7)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SvgPicture.asset(
            'assets/icons/Back.svg',
            color: Colors.white,
          ),
        ),
      ),
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
                      color: Color(0xff171717))),
            ),
            SizedBox(
              height: Adaptive.h(0.5),
            ),
            SizedBox(
              width: Adaptive.w(70),
              child: Text(
                description,
                style: GoogleFonts.plusJakartaSans(
                    textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
              ),
            ),
            SizedBox(
              height: Adaptive.h(2.5),
            ),
          ],
        )
      ],
    );
  }

  Widget jobDetailTilte() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                      child: Image.asset(
                        'assets/icons/saudi_flag.png',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Job available in UAE , free\nvisa & ticket',
                          style: GoogleFonts.plusJakartaSans(
                              textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Instagram Social Manager & Content\nCreator',
                          style: GoogleFonts.plusJakartaSans(
                              textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          )),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          '\$1100 - \$12.000/Month',
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
                      'Saudi Arabia',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                  ],
                ),
                Text(
                  'Expires: 11 hours!',
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
    );
  }
}

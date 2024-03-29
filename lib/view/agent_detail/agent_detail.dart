import 'dart:developer';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/controller/man_power_controller.dart';
import 'package:job_app/model/job_model.dart';
import 'package:job_app/constants/constants.dart';
import 'package:job_app/view/home_page/details/job_list_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class AgentDetailPage extends StatefulWidget {
  AgentDetailPage({super.key, required this.licenseNo, this.imageLink});

  String licenseNo;
  String? imageLink;

  @override
  State<AgentDetailPage> createState() => _AgentDetailPageState();
}

class _AgentDetailPageState extends State<AgentDetailPage> {
  ManPowerController manPowerController = Get.put(ManPowerController());

  @override
  void initState() {
    super.initState();
    log('licence init no is ${widget.licenseNo}');
    manPowerController.getManPowerDetail(widget.licenseNo);
    manPowerController.getAgentJobs(widget.licenseNo);
  }

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

  void openWhatsApp(String number) async {
    // The phone number or WhatsApp link you want to open
    String phoneNumber = number;
    // String whatsappUrl = "https://wa.me/$phoneNumber";
    String url =
        'whatsapp://send?phone=$phoneNumber&text=${Uri.encodeFull('hello')}';
    launchUrl(Uri.parse('https://wa.me/$number?text=Hi'),
        mode: LaunchMode.externalApplication);
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  void openMessenger(String messengerLink) async {
    try {
      // The Facebook profile or Messenger link you want to open
      print('messenger link is $messengerLink');
      //106019062569308
      await launchUrl(Uri.parse('https://www.messenger.com/t/$messengerLink'),
              mode: LaunchMode.externalApplication)
          .then((value) {
        print('link open');
      }).catchError((e) {
        print('error is ${e.toString()}');
      });

      // if (await canLaunch(messengerUrl)) {
      //   await launch(messengerUrl);
      // } else {
      //   throw 'Could not launch $messengerUrl';
      // }

    } catch (e) {
      print('Error is ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.imageLink == null
              ? Container(
                  alignment: Alignment.center,
                  height: Adaptive.px(218),
                  width: Adaptive.w(100),
                  decoration: BoxDecoration(
                      //color: Colors.amber,
                      image: DecorationImage(
                          image: AssetImage('assets/icons/company_image.png'),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: Adaptive.w(5), bottom: Adaptive.h(10)),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headerImage(),
                      ],
                    ),
                  ),
                )
              : widget.imageLink == '----'
                  ? Container(
                      alignment: Alignment.center,
                      height: Adaptive.px(218),
                      width: Adaptive.w(100),
                      decoration: BoxDecoration(
                          //color: Colors.amber,
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/icons/company_image.png'),
                              fit: BoxFit.cover)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: Adaptive.w(5), bottom: Adaptive.h(10)),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headerImage(),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: Adaptive.px(218),
                      width: Adaptive.w(100),
                      decoration: BoxDecoration(
                          //color: Colors.amber,
                          image: DecorationImage(
                              image: NetworkImage(widget.imageLink!),
                              fit: BoxFit.cover)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: Adaptive.w(5), bottom: Adaptive.h(10)),
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
                return !cont.isDataExists.value
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
                                EdgeInsets.symmetric(horizontal: Adaptive.w(6)),
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
                                          color: lightGrey)),
                                ),
                                SizedBox(
                                  height: Adaptive.h(2),
                                ),
                                ExpandableText(
                                  cont.getManPowerData.about!,
                                  maxLines: 3,
                                  expandText: 'Read more',
                                  collapseText: 'Show less',
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
                                    'agent_details'.tr,
                                    style: GoogleFonts.plusJakartaSans(
                                        textStyle: const TextStyle(
                                      color: lightGrey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  height: Adaptive.h(2),
                                ),
                                InfoTile(
                                    'assets/icons/bi_person.svg',
                                    'name'.tr,
                                    cont.getManPowerData.manpowerName!,
                                    () {},
                                    1),
                                SizedBox(
                                  height: Adaptive.h(2),
                                ),
                                InfoTile(
                                    'assets/icons/location.svg',
                                    'location'.tr,
                                    cont.getManPowerData.location!, () {
                                  launchURL(cont.getManPowerData.googleMap!);
                                }, 2),
                                SizedBox(
                                  height: Adaptive.h(2),
                                ),
                                // InfoTile('assets/icons/call.svg', 'Phone',
                                //     cont.getManPowerData.phone_1!, () {}, 3),

                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/call.svg'),
                                    SizedBox(
                                      width: Adaptive.w(5),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'phone'.tr,
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
                                            SizedBox(
                                              width: Adaptive.w(20),
                                              child: GestureDetector(
                                                onTap: () {
                                                  launchCaller(cont
                                                      .getManPowerData
                                                      .phone_1!);
                                                },
                                                child: Text(
                                                  cont.getManPowerData.phone_1!,
                                                  maxLines: 2,
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                          textStyle:
                                                              const TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Adaptive.w(3),
                                            ),
                                            cont.getManPowerData.phone_2! ==
                                                    '----'
                                                ? SizedBox()
                                                : GestureDetector(
                                                    onTap: () {
                                                      launchCaller(cont
                                                          .getManPowerData
                                                          .phone_2!);
                                                    },
                                                    child: Text(
                                                      cont.getManPowerData
                                                          .phone_2!,
                                                      maxLines: 2,
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              textStyle:
                                                                  const TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        color: Colors.blue,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      )),
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: Adaptive.w(3),
                                            ),
                                            cont.getManPowerData.phone_3! ==
                                                    '----'
                                                ? SizedBox()
                                                : GestureDetector(
                                                    onTap: () {
                                                      launchCaller(cont
                                                          .getManPowerData
                                                          .phone_3!);
                                                    },
                                                    child: Text(
                                                      cont.getManPowerData
                                                          .phone_3!,
                                                      maxLines: 2,
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              textStyle:
                                                                  const TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        color: Colors.blue,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                  height: Adaptive.h(2),
                                ),
                                InfoTile(
                                    'assets/icons/licence.svg',
                                    'license_number'.tr,
                                    cont.getManPowerData.licenseNo!,
                                    () {},
                                    4),
                                SizedBox(
                                  height: Adaptive.h(1),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    socialMediaTile(
                                        'Whatsapp',
                                        'assets/icons/whatsapp.svg',
                                        1,
                                        cont.getManPowerData.whatsapp!),
                                    socialMediaTile(
                                        'Messenger',
                                        'assets/icons/messenger.svg',
                                        2,
                                        cont.getManPowerData.messenger!)
                                  ],
                                ),

                                SizedBox(
                                  height: Adaptive.h(1),
                                ),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'agent_posts'.tr,
                                    style: GoogleFonts.plusJakartaSans(
                                        textStyle: const TextStyle(
                                      fontSize: 18,
                                      color: lightGrey,
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
                                          isSavedJObs: false,
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

  int selededIndex = 0;
  Widget socialMediaTile(
      String title, String iconPath, int index, String phoneNumber) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selededIndex = index;
          if (index == 1) {
            openWhatsApp(phoneNumber);
          } else {
            openMessenger(phoneNumber);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Adaptive.w(6), vertical: Adaptive.h(1.5)),
        decoration: BoxDecoration(
          color: selededIndex == index ? primaryColor : null,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: primaryColor),
        ),
        child: Row(
          children: [
            SvgPicture.asset(iconPath,
                height: Adaptive.px(20),
                color: selededIndex == index ? Colors.white : primaryColor),
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color:
                          selededIndex == index ? Colors.white : primaryColor)),
            ),
          ],
        ),
      ),
    );
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

  Widget InfoTile(String iconPath, String title, String description,
      Function()? onTap, int index) {
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
                child: index == 2 || index == 3
                    ? Text(
                        description,
                        style: GoogleFonts.plusJakartaSans(
                            textStyle: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                      )
                    : Text(
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
      ),
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

class DescriptionTile extends StatefulWidget {
  final String description;

  DescriptionTile({required this.description});

  @override
  _DescriptionTileState createState() => _DescriptionTileState();
}

class _DescriptionTileState extends State<DescriptionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.description.split('\n').take(3).join('\n'),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
      children: [
        Text(widget.description),
      ],
      onExpansionChanged: (expanded) {
        setState(() {
          isExpanded = expanded;
        });
      },
      initiallyExpanded: false,
      trailing: isExpanded ? null : Icon(Icons.arrow_drop_down),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/controller/country_controller.dart';
import 'package:job_app/controller/job_controller.dart';
import 'package:job_app/model/job_model.dart';
import 'package:job_app/path.constants.dart';
import 'package:job_app/view/agent_detail/agent_detail.dart';
import 'package:job_app/constants/constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
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
    launchUrl(Uri.parse('https://maps.app.goo.gl/UrHDuYctA8RgWWsz8'),
        //'https://www.google.com/maps/place/Kathmandu+44600,+Nepal/@27.709034,85.178475,12z/data=!3m1!4b1!4m6!3m5!1s0x39eb198a307baabf:0xb5137c1bf18db1ea!8m2!3d27.7172453!4d85.3239605!16zL20vMDRjeDU?entry=ttu'),
        mode: LaunchMode.externalApplication);

    // if (await canLaunchUrl(Uri.parse(
    //     'https://www.google.com/maps/place/Kathmandu+44600,+Nepal/@27.709034,85.178475,12z/data=!3m1!4b1!4m6!3m5!1s0x39eb198a307baabf:0xb5137c1bf18db1ea!8m2!3d27.7172453!4d85.3239605!16zL20vMDRjeDU?entry=ttu'))) {
    //   await launchUrl(Uri.parse(url));
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  launchCaller(String phoneNumber) async {
    if (await canLaunch("tel:$phoneNumber")) {
      await launch("tel:$phoneNumber");
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  static const _locale = 'en';

  String _formatNumber(String s) {
    print('string is $s ');

    return NumberFormat.decimalPattern(_locale)
        .format(int.parse(s.replaceAll('.', '')));
  }

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

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  Uri? url;
  Future<void> createDynamicLink(bool short, String link) async {
    print('link is $link');
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      link: Uri.parse(kUriPrefix + link),
      uriPrefix: kUriPrefix,
      androidParameters: const AndroidParameters(
          packageName: 'com.baideshik.rojgarjob', minimumVersion: 0),
      socialMetaTagParameters: SocialMetaTagParameters(
          title: 'Baideshik Rojgar',
          description: 'about',
          imageUrl: Uri.parse(
              'https://firebasestorage.googleapis.com/v0/b/job-app-75235.appspot.com/o/splash_image.jpg?alt=media&token=38dfa4a1-12fc-457e-ab68-3711237dc4d3')),
    );

    final ShortDynamicLink shortLink =
        await dynamicLinks.buildShortLink(parameters);
    url = shortLink.shortUrl;

    // if (short) {

    // } else {
    //   url = await dynamicLinks.buildLink(parameters);
    // }
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

  CountryController countryController = Get.put(CountryController());

  @override
  void initState() {
    countryController.getAboutCountyrData(widget.jObsModel.country!);

    createDynamicLink(
        true, '/productpage?id=${widget.jObsModel.jobIdentifier}');

    widget.jObsModel.estimatedSalary =
        _formatNumber(widget.jObsModel.estimatedSalary!.replaceAll(',', ''));
    widget.jObsModel.sallary =
        _formatNumber(widget.jObsModel.sallary!.replaceAll(',', ''));

    super.initState();
  }

  AuthcController authcController = Get.put(AuthcController());

  JobController jobController = Get.put(JobController());

  String formatDate(String originalDate) {
    DateTime parsedDate = DateTime.parse(originalDate);
    String formattedDate = DateFormat('y MMMM d').format(parsedDate);

    return formattedDate;
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
                          authcController.languageCode == 'en'
                              ? widget.jObsModel.headline!.replaceAll('?', '')
                              : widget.jObsModel.headlineNepali!
                                          .replaceAll('?', '') ==
                                      '----'
                                  ? widget.jObsModel.headline!
                                      .replaceAll('?', '')
                                  : widget.jObsModel.headlineNepali!
                                      .replaceAll('?', ''),
                          // widget.jObsModel.headline!.replaceAll('?', ''),
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
                          GestureDetector(
                              onTap: () {
                                launchCaller(
                                    widget.jObsModel.recruitingAgencyPhone_1!);
                              },
                              child: SvgPicture.asset(
                                  'assets/icons/phone_Icon.svg')),
                          SizedBox(
                            width: Adaptive.w(5),
                          ),
                          authcController.firebaseUser.value == null
                              ? SizedBox()
                              : GetBuilder<JobController>(
                                  init: Get.put(JobController()),
                                  builder: (cont) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (cont.savedJobsId.contains(
                                            widget.jObsModel.jobIdentifier!)) {
                                          ScaffoldMessenger.of(Get.context!)
                                              .showSnackBar(SnackBar(
                                            backgroundColor: primaryColor,
                                            content: Text(
                                                'You already save this job!'
                                                    .toUpperCase()),
                                            behavior: SnackBarBehavior.floating,
                                          ));
                                        } else {
                                          dialoger(
                                            context,
                                            'Save Job',
                                            'Do you want to save this job?',
                                          );
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        'assets/icons/book_mark_cirlce.svg',
                                        color: cont.savedJobsId.contains(
                                                widget.jObsModel.jobIdentifier!)
                                            ? primaryColor
                                            : null,
                                      ),
                                    );
                                  }),
                          SizedBox(
                            width: Adaptive.w(5),
                          ),
                          GestureDetector(
                              onTap: () {
                                Share.share(url.toString());
                              },
                              child: SvgPicture.asset(
                                  'assets/icons/circle_icon.svg')),
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
                                      ? 'expires'.tr + ' : ' + 'today'.tr
                                      : 'expires'.tr +
                                          ' : ' +
                                          '${calculateExpiryDate()}' +
                                          " " +
                                          'days'.tr,
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
                    'job_detail'.tr,
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
                    'salary'.tr,
                    widget.jObsModel.sallary!.isNotEmpty
                        ? 'रू.${widget.jObsModel.estimatedSalary} (${widget.jObsModel.sallary} ${widget.jObsModel.currency}) '
                        : 'रू.${widget.jObsModel.estimatedSalary}'),
                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile('assets/icons/employer.svg', 'employer'.tr,
                    '${widget.jObsModel.employerName}, ${widget.jObsModel.employerLocation} '),
                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile(
                  'assets/icons/job_type.svg',
                  'job_type'.tr,
                  widget.jObsModel.jobTitleNepali!.isNotEmpty
                      ? "${widget.jObsModel.jobTitle!} (${widget.jObsModel.jobTitleNepali!})  "
                      : "${widget.jObsModel.jobTitle!}",
                ),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile(
                    'assets/icons/gender.svg',
                    'gender'.tr,
                    '  ${widget.jObsModel.maleQuotaApproved}  ' +
                        'males'.tr +
                        ',' +
                        '  ${widget.jObsModel.femaleQuotaApproved} ' +
                        'females'.tr),
                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile(
                    'assets/icons/deadline.svg',
                    'deadline'.tr,
                    widget.jObsModel.deadlineBS!.isNotEmpty
                        ? "${formatDate(widget.jObsModel.deadlineAd!.split(' ').first)}   (${widget.jObsModel.deadlineBS!}) "
                        : "${formatDate(widget.jObsModel.deadlineAd!.split(' ').first)} "),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                Obx(
                  () => InfoTile(
                      'assets/icons/qualification.svg',
                      'qualifications'.tr,
                      authcController.getlanguageCode == 'en'
                          ? widget.jObsModel.qualification!
                          : widget.jObsModel.qualificationNepali!),
                ),
                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                Obx(
                  () => InfoTile(
                      'assets/icons/qualification.svg',
                      'skill_type'.tr,
                      authcController.languageCode == 'en'
                          ? widget.jObsModel.skillType!
                          : widget.jObsModel.skillTypeNepali!),
                ),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile('assets/icons/lot_no.svg', 'Lot. No.'.tr,
                    widget.jObsModel.lotNumber!),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile('assets/icons/deadline.svg', 'daily_working_hours'.tr,
                    widget.jObsModel.dailyWorkHour!),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile('assets/icons/deadline.svg', 'weely_working_hours'.tr,
                    widget.jObsModel.weeklyWorkDay!),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile(
                    'assets/icons/salary.svg',
                    'contract_period'.tr,
                    "${widget.jObsModel.contractPeriodinYears!}" +
                        ' ' "years".tr),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                InfoTile('assets/icons/salary.svg', 'service_charge'.tr,
                    widget.jObsModel.totalExpense!),
                SizedBox(
                  height: Adaptive.h(3),
                ),

                //
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'other_facilities'.tr,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
                  child: GetX<CountryController>(
                      init: Get.put(CountryController()),
                      builder: (cont) {
                        return cont.getaboutCountry.isEmpty
                            ? SizedBox()
                            : HtmlWidget(cont.getaboutCountry);
                      }),
                ),
                //   otherFacilites(widget.jObsModel.other!),
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
                    'man_power_details'.tr,
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
                Obx(
                  () => manPowerTile(
                      'assets/icons/bi_person.svg',
                      'name'.tr,
                      authcController.getlanguageCode == 'en'
                          ? widget.jObsModel.recruitingAgencyName!
                          : widget.jObsModel.recruitingAgencyNameNepali!, () {
                    Get.to(() => AgentDetailPage(
                          licenseNo: widget.jObsModel.licenseNo!,
                        ));
                  }),
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                Obx(
                  () => manPowerTile(
                      'assets/icons/location.svg',
                      'location'.tr,
                      authcController.getlanguageCode == 'en'
                          ? widget.jObsModel.recruitingAgencyLocation!
                          : widget.jObsModel.recruitingAgencyLocationNepali!,
                      () {
                    launchURL(widget.jObsModel.locationGoogleMap!);
                  }),
                ),
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
                            widget.jObsModel.recruitingAgencyPhone_2! != '----'
                                ? GestureDetector(
                                    onTap: () {
                                      launchCaller(widget
                                          .jObsModel.recruitingAgencyPhone_2!);
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
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    socialMediaTile('Whatsapp', 'assets/icons/whatsapp.svg', 1,
                        widget.jObsModel.whatsappLink!),
                    socialMediaTile('Messenger', 'assets/icons/messenger.svg',
                        2, widget.jObsModel.messangerLink!)
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

  int selededIndex = 0;
  Widget socialMediaTile(
      String title, String iconPath, int index, String phoneNumber) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selededIndex = index;
          if (index == 1) {
            print('open $phoneNumber');
            openWhatsApp(phoneNumber);
          } else {
            print('open $phoneNumber');
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/constants/constants.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/view/about_us/about_us_page.dart';
import 'package:job_app/view/change_language_page/change_language_page.dart';
import 'package:job_app/view/pick_file.dart';
import 'package:job_app/view/privacy_policy/privacy_policy.dart';
import 'package:job_app/view/term_and_condition/term_and_condition_page.dart';
import 'package:job_app/view/widgets/primary_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MenuPage> {
  AuthcController authcController = Get.put(AuthcController());
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    if (authcController.firebaseUser.value != null) {
      authcController.getData();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: Adaptive.h(5),
            ),
            Text(
              'About',
              style: GoogleFonts.plusJakartaSans(
                  textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              )),
            ),
            SizedBox(
              height: Adaptive.h(3),
            ),
            itemTile('assets/icons/terms_condition.svg', 'Terms & Condition ',
                () {
              Get.to(() => TermsandConditionPage());
            }),
            SizedBox(
              height: Adaptive.h(2),
            ),
            const Divider(),
            itemTile('assets/icons/privacy_policy.svg', 'Privacy Policy', () {
              Get.to(() => PrvacyPolicy());
            }),
            SizedBox(
              height: Adaptive.h(2),
            ),
            const Divider(),
            itemTile('assets/icons/about_us.svg', 'Change language', () {
              Get.to(ChangeLanguagePage());
            }),
            const Divider(),
            itemTile('assets/icons/contact_us.svg', 'About us', () {
              Get.to(() => AboutUsPage());
            }),
            const Divider(),
            Obx(
              () => authcController.getUserData.email == null ||
                      authcController.firebaseUser.value == null
                  ? SizedBox()
                  : authcController.getUserData.email!.toLowerCase() ==
                              'puribijay@gmail.com' ||
                          authcController.getUserData.email!.toLowerCase() ==
                              'baideshikrojgar.np@gmail.com' ||
                          authcController.getUserData.email!.toLowerCase() ==
                              'firebasebijay@gmail.com' ||
                          authcController.getUserData.email!.toLowerCase() ==
                              'bai.ro.nepal@gmail.com' ||
                          authcController.getUserData.email!.toLowerCase() ==
                              'bnazir839@gmail.com'
                      ? Column(
                          children: [
                            itemTile('assets/icons/upload.svg', 'Upload data',
                                () {
                              Get.to(() => MyCSVUploader());

                              //   dialoger(context, 'Enter Admin email');
                            }),
                            const Divider(),
                          ],
                        )
                      : SizedBox(),
            ),
            itemTile('assets/icons/log_out.svg', 'Log out', () {
              authcController.signOut();
            }),
          ]),
        ),
      ),
    );
  }

  dialoger(
    BuildContext context,
    String title,
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
              height: Adaptive.h(20),
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: PrimaryField(
                          controller: controller,
                          hintText: 'Email',
                          isPasswordField: false,
                          prefixIcon: FontAwesomeIcons.envelope,
                          validator: (email) {},
                        ),
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
                            child: Text('Cancel',
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
//                               Puribijay@gmail.com
// firebasebijay@gmail.com
// bai.ro.nepal@gmail.com
// baideshikrojgar.np@gmail.com
                              //  Get.to(() => MyCSVUploader());
                              if (controller.text.isNotEmpty) {
                                if (controller.text.toLowerCase() ==
                                        'puribijay@gmail.com' ||
                                    controller.text.toLowerCase() ==
                                        'baideshikrojgar.np@gmail.com' ||
                                    controller.text.toLowerCase() ==
                                        'firebasebijay@gmail.com' ||
                                    controller.text.toLowerCase() ==
                                        'bai.ro.nepal@gmail.com') {
                                  Get.back();
                                  controller.clear();
                                  Get.to(() => MyCSVUploader());
                                } else {
                                  Get.back();
                                  controller.clear();

                                  ScaffoldMessenger.of(Get.context!)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: primaryColor,
                                    content: Text('Wrong Email'.toUpperCase()),
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                }
                              }
                            },
                            child: Text('Confirm',
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

  Widget itemTile(String iconPath, String text, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                  color: primaryColor,
                ),
                SizedBox(
                  width: Adaptive.w(5),
                ),
                Text(
                  text,
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )),
                ),
              ],
            ),
            SvgPicture.asset('assets/icons/arrow_forward.svg'),
          ],
        ),
      ),
    );
  }
}

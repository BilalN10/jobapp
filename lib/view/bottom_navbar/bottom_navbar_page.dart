import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/controller/country_controller.dart';
import 'package:job_app/controller/job_controller.dart';
import 'package:job_app/view/authentication_pages/login_page.dart';
import 'package:job_app/view/country_page/country_page.dart';
import 'package:job_app/view/agent_list/agents_list.dart';
import 'package:job_app/constants/constants.dart';
import 'package:job_app/view/home_page/home_page.dart';
import 'package:job_app/view/log_out/log_out_page.dart';
import 'package:job_app/view/pick_file.dart';
import 'package:job_app/view/menu/menu_page.dart';
import 'package:job_app/view/saved_jobs/saved_jobs_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  AuthcController authcController = Get.put(AuthcController());
  List<Widget> withAuthpages = [
    const HomePage(),
    SavedJobs(),
    CountryPage(),
    const AgentListPage(),
    // Container(),
    //MyCSVUploader(),

    const LogOutPage()
    // LoginPage()
  ];

  List<Widget> withAuthOutpages = [
    const HomePage(),
    SavedJobs(),
    CountryPage(),
    const AgentListPage(),
    LoginPage()
  ];
  JobController jobController = Get.put(JobController());
  CountryController countryController = Get.put(CountryController());

  @override
  void initState() {
    if (authcController.firebaseUser.value != null) {
      jobController.getAllSavedJobs();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final adjustedFontSize = 16.0 * textScaleFactor;
    return WillPopScope(
        onWillPop: () async {
          final shouldExit = await dialoger(context, 'Exit App?',
              'Do you want to exit the app?'); //showConfirmationDialog(context);
          if (shouldExit) {
            return true;
          } else {
            return false;
          }
        },
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(() => Expanded(
                  child: authcController.firebaseUser.value != null
                      ? withAuthpages[jobController.selectedBottomTab.value]
                      : withAuthOutpages[
                          jobController.selectedBottomTab.value])),
              Container(
                height: Adaptive.h(10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black12,
                          offset: Offset(-2, -2))
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Adaptive.w(6)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        bottomTile('assets/icons/bottom_home.svg', 'home'.tr, 0,
                            adjustedFontSize),
                        bottomTile('assets/icons/bottom_bookmark.svg',
                            'my_job'.tr, 1, adjustedFontSize),

                        bottomTile('assets/icons/global.svg', 'country'.tr, 2,
                            adjustedFontSize),
                        bottomTile('assets/icons/agent.svg', 'manpowers'.tr, 3,
                            adjustedFontSize),
                        // bottomTile('assets/icons/bottom_notification.svg',
                        //     'notification'.tr, 3, adjustedFontSize),
                        bottomTile('assets/icons/Combined-Shape.svg',
                            'profile'.tr, 4, adjustedFontSize)
                      ]),
                ),
              )
            ],
          ),
        ));
  }

  Future<dynamic> dialoger(
    BuildContext context,
    String title,
    String subTitle,
  ) async {
    return showDialog(
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
                              Navigator.of(context).pop(false);
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
                              Navigator.of(context).pop(true);
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

  Future<dynamic> showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exit App?"),
          content: Text("Do you want to exit the app?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  Widget bottomTile(String iconPath, String name, int index, double fontSize) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            jobController.isShowJobs.value = false;
            jobController.isfilter.value = false;

            jobController.selectedBottomTab.value = index;
          });
        },
        child: Obx(
          () => Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            color: Colors.transparent,
            //padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  color: jobController.selectedBottomTab.value == index
                      ? primaryColor
                      : lightGrey,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                          fontSize: Adaptive.px(12),
                          fontWeight: FontWeight.w500,
                          color: jobController.selectedBottomTab.value == index
                              ? primaryColor
                              : lightGrey)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

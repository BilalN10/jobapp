import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/controller/job_controller.dart';
import 'package:job_app/view/agent_list/agents_list.dart';
import 'package:job_app/view/constants/constants.dart';
import 'package:job_app/view/home_page/home_page.dart';
import 'package:job_app/view/pick_file.dart';
import 'package:job_app/view/profile/profile_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

List<Widget> pages = [
  const HomePage(),
  const AgentListPage(),
  MyCSVUploader(),
  const ProfilePage()
];
JobController jobController = Get.put(JobController());

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldExit = await showConfirmationDialog(context);
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
                  child: pages[jobController.selectedBottomTab.value])),
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
                        bottomTile('assets/icons/bottom_home.svg', 'Home', 0),
                        bottomTile('assets/icons/agent.svg', 'Manpowers', 1),
                        bottomTile('assets/icons/bottom_notification.svg',
                            'Notification', 2),
                        bottomTile(
                            'assets/icons/Combined-Shape.svg', 'Profile', 3)
                      ]),
                ),
              )
            ],
          ),
        ));
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

  Widget bottomTile(String iconPath, String name, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            jobController.isShowJobs.value = false;

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
                // index == 3 && selectedTab == index
                //     ? Column(
                //         children: [
                //           SvgPicture.asset(
                //             'assets/icons/profile_circle.svg',
                //             height: Adaptive.h(1.5),
                //             color: primaryColor,
                //           ),
                //           SizedBox(
                //             height: 1,
                //           ),
                //           SvgPicture.asset(
                //             'assets/icons/profile_down_circle.svg',
                //             height: Adaptive.h(1),
                //             color: primaryColor,
                //           ),
                //         ],
                //       )
                //     : index == 2 && selectedTab == index
                //         ? Column(
                //             children: [
                //               SvgPicture.asset(
                //                 'assets/icons/fill_notification.svg',
                //                 color: primaryColor,
                //               ),
                //             ],
                //           )
                //         : SvgPicture.asset(
                //             iconPath,
                //             color:
                //                 selectedTab == index ? primaryColor : lightGrey,
                //           ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                          fontSize: 12,
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

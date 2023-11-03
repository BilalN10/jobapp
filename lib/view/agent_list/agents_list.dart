import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/controller/job_controller.dart';
import 'package:job_app/controller/man_power_controller.dart';
import 'package:job_app/model/man_power_detail.dart';
import 'package:job_app/view/agent_detail/agent_detail.dart';
import 'package:job_app/constants/constants.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgentListPage extends StatefulWidget {
  const AgentListPage({super.key});

  @override
  State<AgentListPage> createState() => _AgentListState();
}

class _AgentListState extends State<AgentListPage> {
  ManPowerController manPowerController = Get.put(ManPowerController());
  JobController jobController = Get.put(JobController());

  List<String> imageList = [
    "assets/icons/pic_1.png",
    "assets/icons/pic_2.png",
    "assets/icons/pic_3.png",
    "assets/icons/pic_4.png",
    "assets/icons/pic_5.png",
    "assets/icons/pic_1.png",
  ];

  @override
  void initState() {
    manPowerController.scrollController.addListener(() {
      if (manPowerController.scrollController.position.pixels ==
          manPowerController.scrollController.position.maxScrollExtent) {
        print('enter in scroll control');
        // If the user has reached the bottom of the list, load more items
        if (!manPowerController.loading && manPowerController.hasMoreItems) {
          Get.put(ManPowerController()).pageNumber++;
          Get.put(ManPowerController()).loading = true;
          Get.put(ManPowerController()).loadMoreItems();
          Get.put(ManPowerController()).update();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            height: Adaptive.h(3),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Adaptive.w(7)),
            child: headerTile(),
          ),
          SizedBox(
            height: Adaptive.h(3),
          ),

          Expanded(
            child: Scrollbar(
              isAlwaysShown: true,
              child: PaginateFirestore(
                initialLoader: CircularProgressIndicator(),
                itemBuilderType:
                    PaginateBuilderType.listView, //Change types accordingly
                itemBuilder: (context, documentSnapshots, index) {
                  if (documentSnapshots[index].exists) {
                    print('last index is ${documentSnapshots.last}');
                    final data = documentSnapshots[index].data() as Map?;
                    ManPowerDetail manPowerDetail =
                        ManPowerDetail.fromFirestore(data!);
                    return agentListTile(manPowerDetail);
                  } else {
                    return Text('not found');
                  }
                },
                bottomLoader: Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ),
                query: FirebaseFirestore.instance.collection('manpower'),
                itemsPerPage: 20,
                isLive: true,
                padding: EdgeInsets.only(bottom: 50),
              ),
            ),
          ),

          // Expanded(child: Scrollbar(child: PaginateFirestore(itemBuilder:   (context, documentSnapshots, index) {
          //                       if (documentSnapshots[index].exists) {
          //                         print(
          //                             'last index is ${documentSnapshots.last}');
          //                         final data =
          //                             documentSnapshots[index].data() as Map?;
          //                         ManPowerDetail manPowerDetail =
          //                             ManPowerDetail.fromFirestore(data!);
          //                        return agentListTile(
          //                         manPowerDetail

          //                        );
          //                     }; query:  FirebaseFirestore.instance
          //                         .collection('jobs')
          //                         .orderBy('date_time', descending: false); itemBuilderType:  PaginateBuilderType.listView;

          //                          )))

          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: Adaptive.w(0)),
          //   child: GetBuilder<ManPowerController>(
          //       init: Get.put(ManPowerController()),
          //       builder: (cont) {
          //         return SizedBox(
          //           height: Adaptive.h(100),
          //           child: Padding(
          //             padding: const EdgeInsets.only(bottom: 0),
          //             child: ListView.builder(
          //               // shrinkWrap: true,
          //               // physics: const NeverScrollableScrollPhysics(),
          //               itemCount: manPowerController.manList.length + 1,
          //               itemBuilder: (BuildContext context, int index) {
          //                 if (index == manPowerController.manList.length) {
          //                   // If the index is equal to the length of the items list,
          //                   // then we are at the end of the list and we need to load more items
          //                   if (manPowerController.loading ||
          //                       !manPowerController.hasMoreItems) {
          //                     if (manPowerController.loading &&
          //                         manPowerController.hasMoreItems) {
          //                       manPowerController.loadMoreItems();
          //                       return const Center(
          //                           child: CircularProgressIndicator(
          //                         color: Colors.amber,
          //                       ));
          //                     } else {
          //                       return const SizedBox();
          //                     }

          //                     // If we are already loading more items or there are no more items to load, return a loading spinner
          //                     //  Center(
          //                     //     child: CircularProgressIndicator(
          //                     //   color: Colors.amber,
          //                     // ));
          //                   } else {
          //                     // Otherwise, load more items
          //                     manPowerController.pageNumber++;
          //                     manPowerController.loading = true;
          //                     manPowerController.loadMoreItems();
          //                     if (manPowerController.manList.isEmpty) {
          //                       return SizedBox();
          //                     } else {
          //                       return const Center(
          //                           child: CircularProgressIndicator(
          //                         color: Colors.green,
          //                       ));
          //                     }
          //                   }
          //                 } else {
          //                   //  jobid = jobsList[jobsList.length].jobId!;

          //                   // Otherwise, return a JobListTile widget for the item
          //                   return agentListTile(
          //                       manPowerController.manList[index]);
          //                 }
          //               },
          //               controller: manPowerController.scrollController,
          //             ),
          //           ),
          //         );
          //       }),
          // )
        ]),
      ),
    );
  }

  Widget agentListTile(ManPowerDetail manPowerDetail) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
      child: GestureDetector(
        onTap: () {
          Get.to(() => AgentDetailPage(
                imageLink: manPowerDetail.photoLink,
                licenseNo: manPowerDetail.licenseNo!,
              ));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(blurRadius: 10, color: Colors.black12)
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  manPowerDetail.iconLink == '----'
                      ? Container(
                          height: Adaptive.h(12),
                          width: Adaptive.w(28),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              //  color: Colors.amber,
                              image: DecorationImage(
                                  image: AssetImage("assets/icons/pic_1.png"),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high)),
                        )
                      : Container(
                          height: Adaptive.h(12),
                          width: Adaptive.w(28),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              //  color: Colors.amber,
                              image: DecorationImage(
                                  image: NetworkImage(manPowerDetail.iconLink!),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high)),
                        ),

                  // manPowerDetail.iconLink!.isNotEmpty?
                  SizedBox(
                    width: Adaptive.w(2),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Adaptive.w(47),
                        child: Text(
                          manPowerDetail.manpowerName!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                              textStyle: TextStyle(
                                  fontSize: Adaptive.px(13),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        height: Adaptive.h(1),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/location.svg',
                            color: lightGrey,
                            height: Adaptive.px(12),
                          ),
                          SizedBox(
                            width: Adaptive.w(2),
                          ),
                          SizedBox(
                            width: Adaptive.w(47),
                            child: Text(
                              manPowerDetail.location!,
                              maxLines: 2,
                              style: GoogleFonts.plusJakartaSans(
                                  textStyle: TextStyle(
                                      fontSize: Adaptive.px(12),
                                      fontWeight: FontWeight.w400,
                                      color: lightGrey)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Adaptive.h(1),
                      ),
                      Text(
                        manPowerDetail.manager!,
                        style: GoogleFonts.plusJakartaSans(
                            textStyle: TextStyle(
                                fontSize: Adaptive.px(12),
                                fontWeight: FontWeight.w400,
                                color: primaryColor)),
                      ),
                      SizedBox(
                        height: Adaptive.h(1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Adaptive.w(47),
                            child: Text(
                              manPowerDetail.phone_1!,
                              style: GoogleFonts.plusJakartaSans(
                                  textStyle: TextStyle(
                                      fontSize: Adaptive.px(12),
                                      fontWeight: FontWeight.w400,
                                      color: lightGrey)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Text(
              //       '5.0',
              //       style: GoogleFonts.plusJakartaSans(
              //           textStyle: TextStyle(
              //               fontSize: Adaptive.px(12),
              //               fontWeight: FontWeight.w400,
              //               color: lightGrey)),
              //     ),
              //     SizedBox(
              //       width: Adaptive.w(2),
              //     ),
              //     SvgPicture.asset('assets/icons/star.svg')
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  Row headerTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () {
              jobController.selectedBottomTab.value = 0;
              //  SystemNavigator.pop();
            },
            child: SvgPicture.asset('assets/icons/Back.svg')),
        Text(
          'Manpower List',
          style: GoogleFonts.aBeeZee(
              textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          )),
        ),
        SizedBox()
        // SvgPicture.asset(
        //   'assets/icons/search.svg',
        //   color: Colors.black,
        // ),
      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:job_app/constants/constants.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/controller/country_controller.dart';
import 'package:job_app/model/country_model.dart';
import 'package:job_app/model/job_model.dart';
import 'package:job_app/view/home_page/details/job_list_page.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class CountryJobs extends StatefulWidget {
  const CountryJobs({super.key, required this.countryModel});
  final CountryModel countryModel;

  @override
  State<CountryJobs> createState() => _CountryJobsState();
}

class _CountryJobsState extends State<CountryJobs> {
  CountryController countryController = Get.put(CountryController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    countryController.getAboutCountyrData(widget.countryModel.countryId!);
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLaod = true;
      });
    });
    super.initState();
  }

  int calculateExpiryDate(String expiryDate) {
    DateTime deadlineDate;

    try {
      deadlineDate = DateTime.parse(expiryDate);
    } catch (e) {
      DateFormat format = DateFormat('dd MMM, yyyy');
      deadlineDate = format.parse(expiryDate);
    }

// Get today's date
    DateTime now = DateTime.now();

// Calculate the difference between the two dates
    Duration difference = deadlineDate.difference(now);

    return difference.inDays;
  }

  // @override
  // void dispose() {
  //   countryController.scrollController.dispose();
  //   // TODO: implement dispose
  //   super.dispose();
  // }
  var unescape = HtmlUnescape();
  AuthcController authcController = Get.put(AuthcController());
  String converter() {
    String text = unescape.convert(
        "<p><strong>Albania</strong> is a country located in<span style='color: #ff6600;'> Southeastern Europe</span> and is officially known as the Republic of Albania.&nbsp;&nbsp;over 50% of the population is dependent on agriculture, foreign businesses have migrated to Albania, creating employment opportunities in industries like energy, textiles, transport infrastructure, and tourism. The country is considered an <span style='color: #ff6600;'>upper-middle-income</span> economy with a high Human Development Index.</p>'");
    return text;
  }

  bool isLaod = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLaod
            ? Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Adaptive.w(5), vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            'assets/icons/Back.svg',
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.countryModel.countryName!,
                          style: GoogleFonts.plusJakartaSans(
                              textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          )),
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
                    child: GetX<CountryController>(
                        init: Get.put(CountryController()),
                        builder: (cont) {
                          return cont.getaboutCountry.isEmpty
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                )
                              : HtmlWidget(cont.getaboutCountry);
                        }),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'posts'.tr,
                        style: GoogleFonts.plusJakartaSans(
                            textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: PaginateFirestore(
                        initialLoader: CircularProgressIndicator(),
                        itemBuilderType: PaginateBuilderType
                            .listView, //Change types accordingly
                        itemBuilder: (context, documentSnapshots, index) {
                          if (documentSnapshots[index].exists) {
                            final data =
                                documentSnapshots[index].data() as Map?;
                            JObsModel jObsModel =
                                JObsModel.fromFirestore(data!);

                            //         documentSnapshots.map((e) =>  JObsModel.fromFirestore(e));

                            return calculateExpiryDate(
                                        jObsModel.deadlineAd!.toString()) <
                                    0
                                ? const SizedBox()
                                : JobListTile(
                                    isSavedJObs: false, jObsModel: jObsModel);
                          } else {
                            return Text('not found');
                          }
                        },
                        bottomLoader: Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                        // orderBy is compulsory to enable pagination
                        query: FirebaseFirestore.instance
                            .collection('country')
                            .doc(widget.countryModel.countryId)
                            .collection('jobs')
                            .orderBy('date_time'),
                        itemsPerPage: 5,
                        // to fetch real-time data
                        isLive: true,
                      ),
                    ),
                  ),

                  // GetBuilder<CountryController>(
                  //     init: Get.put(CountryController()),
                  //     builder: (cont) {
                  //       return Expanded(
                  //         //  height: Adaptive.h(68),
                  //         child: ListView.builder(
                  //           // shrinkWrap: true,
                  //           // physics: const NeverScrollableScrollPhysics(),
                  //           itemCount: cont.countryJobs.length + 1,
                  //           itemBuilder: (BuildContext context, int index) {
                  //             print('job length is ${cont.countryJobs.length} ');

                  //             if (index == cont.countryJobs.length) {
                  //               // If the index is equal to the length of the items list,
                  //               // then we are at the end of the list and we need to load more items
                  //               if (cont.loading || !cont.hasMoreItems) {
                  //                 // If we are already loading more items or there are no more items to load, return a loading spinner

                  //                 if (cont.loading && cont.hasMoreItems) {
                  //                   print('call on 1');
                  //                   cont.loadMoreItems(
                  //                       widget.countryModel.countryId!);
                  //                   return const Center(
                  //                       child: CircularProgressIndicator(
                  //                     color: Colors.red,
                  //                   ));
                  //                 } else {
                  //                   return const SizedBox();
                  //                 }
                  //               } else {
                  //                 cont.pageNumber++;
                  //                 cont.loading = true;
                  //                 print('call on 2');

                  //                 cont.loadMoreItems(widget.countryModel.countryId!);

                  //                 if (cont.countryJobs.isEmpty) {
                  //                   return SizedBox();
                  //                 } else {
                  //                   return const Center(
                  //                       child: CircularProgressIndicator(
                  //                     color: Colors.green,
                  //                   ));
                  //                 }
                  //               }
                  //             } else {
                  //               //  jobid = jobsList[jobsList.length].jobId!;

                  //               // Otherwise, return a JobListTile widget for the item
                  //               return calculateExpiryDate(cont
                  //                           .countryJobs[index].deadlineAd!
                  //                           .toString()) <
                  //                       0
                  //                   ? const SizedBox()
                  //                   : JobListTile(jObsModel: cont.countryJobs[index]);
                  //             }
                  //           },
                  //           controller: scrollController,
                  //         ),
                  //       );
                  //     }),

                  // GetX<CountryController>(
                  //     init: countryController,
                  //     builder: (cont) {
                  //       return Expanded(
                  //         child: ListView.builder(
                  //             itemCount: cont.countryJobs.length,
                  //             itemBuilder: (context, index) {
                  //               return JobListTile(
                  //                   jObsModel: cont.countryJobs[index]);
                  //             }),
                  //       );
                  //     })
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
      ),
    );
  }
}

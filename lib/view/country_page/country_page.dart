import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/controller/country_controller.dart';
import 'package:job_app/controller/job_controller.dart';
import 'package:job_app/view/country_page/country_jobs.dart';
import 'package:job_app/model/country_model.dart';
import 'package:job_app/constants/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  CountryController countryController = Get.put(CountryController());
  JobController jobController = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Adaptive.w(5), vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        jobController.selectedBottomTab.value = 0;
                      },
                      child: SvgPicture.asset(
                        'assets/icons/Back.svg',
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Country',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      )),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          "assets/icons/search.svg",
                          color: Colors.black,
                        )),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: GetX<CountryController>(
                  init: Get.put(CountryController()),
                  builder: (cont) {
                    return GridView.builder(
                      itemCount: cont.getcountryList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.5 / 2,
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        CountryModel countryModel = cont.getcountryList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => CountryJobs(
                                  countryModel: countryModel,
                                ));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 2, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12, blurRadius: 10),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: textScaleFactor *
                                        1.60, // Set the desired aspect ratio here
                                    child: Container(
                                      child: countryModel.countryFlag != null
                                          ? SvgPicture.asset(
                                              countryModel.countryFlag!)
                                          : SizedBox(),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    countryModel.countryName!.tr,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.plusJakartaSans(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '${countryModel.frequency} Job Available',
                                    style: GoogleFonts.plusJakartaSans(
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 8),
              //   child: GetX<CountryController>(
              //       init: Get.put(CountryController()),
              //       builder: (cont) {
              //         return GridView.builder(
              //           itemCount: cont.getcountryList.length,
              //           shrinkWrap: true,
              //           physics: const NeverScrollableScrollPhysics(),
              //           gridDelegate:
              //               const SliverGridDelegateWithFixedCrossAxisCount(
              //             childAspectRatio: 1.5 / 2,
              //             crossAxisCount: 3,
              //           ),
              //           itemBuilder: (BuildContext context, int index) {
              //             CountryModel countryModel =
              //                 cont.getcountryList[index];
              //             return GestureDetector(
              //               onTap: () {
              //                 Get.to(() => CountryJobs(
              //                       countryModel: countryModel,
              //                     ));
              //               },
              //               child: Container(
              //                 margin: EdgeInsets.symmetric(
              //                     horizontal: 2, vertical: 5),
              //                 decoration: BoxDecoration(
              //                     color: Colors.white,
              //                     boxShadow: [
              //                       BoxShadow(
              //                           color: Colors.black12, blurRadius: 10)
              //                     ],
              //                     borderRadius: BorderRadius.circular(10)),
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Column(
              //                     children: [
              //                       Container(
              //                         //  color: Colors.amber,
              //                         height: Adaptive.h(10),
              //                         child: SvgPicture.asset(
              //                             countryModel.countryFlag!),
              //                       ),
              //                       SizedBox(
              //                         height: 5,
              //                       ),
              //                       Text(
              //                         countryModel.countryName!,
              //                         style: GoogleFonts.plusJakartaSans(
              //                             textStyle: const TextStyle(
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.w600,
              //                         )),
              //                       ),
              //                       SizedBox(
              //                         height: 2,
              //                       ),
              //                       Text(
              //                         '${countryModel.frequency} Job Available',
              //                         style: GoogleFonts.plusJakartaSans(
              //                             textStyle: const TextStyle(
              //                                 fontSize: 14,
              //                                 color: primaryColor)),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             );
              //           },
              //         );
              //       }),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

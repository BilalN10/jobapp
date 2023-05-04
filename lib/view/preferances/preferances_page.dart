import 'dart:math';

import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/bottom_navbar/bottom_navbar_page.dart';
import 'package:job_app/controller/job_controller.dart';
import 'package:job_app/model/country_model.dart';
import 'package:job_app/view/constants/constants.dart';
import 'package:job_app/view/preferances/check_box_tile.dart';
import 'package:job_app/view/preferances/job_preferance.dart';
import 'package:job_app/view/preferances/salary_tile.dart';
import 'package:job_app/view/preferances/see_more.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PreferancesPage extends StatefulWidget {
  const PreferancesPage({super.key});

  @override
  State<PreferancesPage> createState() => _PreferancesPageState();
}

class _PreferancesPageState extends State<PreferancesPage> {
  // String gender = 'Male';

  // List of items in our dropdown menu
  var items = ["Male", "Female", "Both"];
  double start = 30.0;
  double end = 50.0;
  List<CountryModel>? countryList;
  @override
  void initState() {
    filterCountry.clear();
    filterJObtype.clear();
    jobController.maxSalary = 0.0;
    jobController.minSalary = 0.0;
    jobController.getJobsType();
    jobController.getCountries();

    // countryList = [
    //   CountryModel(countryName: 'Nepal', value: false),
    //   CountryModel(countryName: 'UAE', value: false),
    //   CountryModel(countryName: 'Pakistan', value: false),
    //   CountryModel(countryName: 'Saudi Arabia', value: false),
    //   CountryModel(countryName: 'USA', value: false),
    //   CountryModel(countryName: 'Albania', value: false),
    //   CountryModel(
    //     countryName: 'Bahrain',
    //     value: false,
    //   ),
    //   CountryModel(countryName: 'Croatia', value: false),
    //   CountryModel(countryName: 'Cyprus', value: false),
    //   CountryModel(countryName: 'Macau SAR,China', value: false),
    //   CountryModel(countryName: 'Mauritius', value: false),
    //   CountryModel(countryName: 'UAE', value: false),
    //   CountryModel(countryName: 'Russia', value: false),
    //   CountryModel(countryName: 'Japan', value: false),
    //   CountryModel(countryName: 'Jordan', value: false),
    //   CountryModel(countryName: 'Kuwait', value: false),
    //   CountryModel(countryName: 'Oman', value: false),
    //   CountryModel(countryName: 'Qatar', value: false),
    //   CountryModel(countryName: 'Romania', value: false),
    //   CountryModel(countryName: 'United Kingdom', value: false),
    // ];

    super.initState();
  }

  List<String> filterCountry = [];
  List<String> filterJObtype = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Adaptive.h(3),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset('assets/icons/cross.svg')),
                    Text(
                      'Preferences',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      )),
                    ),
                    const SizedBox(),
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                Text(
                  'Gender',
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                    fontSize: Adaptive.px(16),
                    fontWeight: FontWeight.bold,
                  )),
                ),
                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: lightGrey)),
                  child: DropdownButton(
                    // Initial Value
                    value: jobController.gender,
                    isExpanded: true,
                    underline: SizedBox(),

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/bi_person.svg',
                              color: primaryColor,
                              height: Adaptive.px(20),
                            ),
                            SizedBox(
                              width: Adaptive.w(2),
                            ),
                            Text(
                              items,
                              style: GoogleFonts.plusJakartaSans(
                                  textStyle: TextStyle(
                                fontSize: Adaptive.px(14),
                                fontWeight: FontWeight.w400,
                              )),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        jobController.gender = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                Text(
                  'Country',
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                    fontSize: Adaptive.px(16),
                    fontWeight: FontWeight.bold,
                  )),
                ),
                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                GetX<JobController>(
                    init: jobController,
                    builder: (cont) {
                      return cont.getcountryList.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : GridView.builder(
                              itemCount: cont.showMoreCountry.value
                                  ? cont.getcountryList.length
                                  : cont.getcountryList.length - 10,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 6 / 2,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return CheckBoxTile(
                                  text: cont.getcountryList[index].countryName!,
                                  value: cont.getcountryList[index].value!,
                                  onChanged: (p0) {
                                    setState(() {
                                      if (filterCountry.length >= 10 &&
                                          !cont.getcountryList[index].value!) {
                                        Get.snackbar('Limit exceeded',
                                            'You can select maximum 10 countries');
                                      } else {
                                        cont.getcountryList[index].value =
                                            !cont.getcountryList[index].value!;
                                        if (cont.getcountryList[index].value!) {
                                          filterCountry.add(cont
                                              .getcountryList[index]
                                              .countryName!);

                                          print(
                                              'country add list is ${filterCountry.length} $filterCountry');
                                        } else {
                                          filterCountry.removeWhere((element) =>
                                              element ==
                                              cont.getcountryList[index]
                                                  .countryName!);
                                          print(
                                              'country remove list is ${filterCountry.length} $filterCountry');
                                        }
                                      }
                                    });
                                  },
                                );
                              },
                            );
                    }),

                //   countryTile(),
                //  showMoreCountry ? moreCountryTile() : const SizedBox(),
                GestureDetector(
                  onTap: () {
                    jobController.showMoreCountry.value =
                        !jobController.showMoreCountry.value;
                  },
                  child: Obx(
                    () => Text(
                      jobController.showMoreCountry.value
                          ? 'See less'
                          : 'See more',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                              fontSize: Adaptive.px(15),
                              fontWeight: FontWeight.w600,
                              color: primaryColor)),
                    ),
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Min. Salary',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                        fontSize: Adaptive.px(16),
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                    Text(
                      'Max. Salary',
                      style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                        fontSize: Adaptive.px(16),
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(3),
                ),
                SalaryTile(),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                Text(
                  'Job Type',
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                    fontSize: Adaptive.px(16),
                    fontWeight: FontWeight.bold,
                  )),
                ),
                GetX<JobController>(
                    init: Get.put(JobController()),
                    builder: (con) {
                      return con.getJobType.isEmpty
                          ? CircularProgressIndicator()
                          : GridView.builder(
                              itemCount: con.showMoreJobType.value
                                  ? con.getJobType.length
                                  : con.getJobType.length - 90,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 6 / 2,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return CheckBoxTile(
                                  text: con.getJobType[index].jobTile!,
                                  value: con.getJobType[index].value!,
                                  onChanged: (p0) {
                                    setState(() {
                                      if (filterJObtype.length >= 10 &&
                                          !con.getJobType[index].value!) {
                                        Get.snackbar('Limit exceeded',
                                            'You can select maximum 10 job types');
                                      } else {
                                        con.getJobType[index].value =
                                            !con.getJobType[index].value!;

                                        if (con.getJobType[index].value!) {
                                          filterJObtype.add(
                                              con.getJobType[index].jobTile!);

                                          print(
                                              'country add list is ${filterJObtype.length} $filterJObtype');
                                        } else {
                                          filterJObtype.removeWhere((element) =>
                                              element ==
                                              con.getJobType[index].jobTile!);
                                          print(
                                              'country remove list is ${filterJObtype.length} $filterJObtype');
                                        }
                                      }
                                    });
                                  },
                                );
                              },
                            );
                    }),

                SeeMore(),

                SizedBox(
                  height: Adaptive.h(2),
                ),

                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                //  jonTypeTile(),
                SizedBox(
                  height: Adaptive.h(3),
                ),
                Text(
                  'Distance (km)',
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                    fontSize: Adaptive.px(16),
                    fontWeight: FontWeight.bold,
                  )),
                ),
                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                DistanceTile(),
                SizedBox(
                  height: Adaptive.h(3),
                ),
                Text(
                  'Other',
                  style: GoogleFonts.plusJakartaSans(
                      textStyle: TextStyle(
                    fontSize: Adaptive.px(16),
                    fontWeight: FontWeight.bold,
                  )),
                ),
                SizedBox(
                  height: Adaptive.h(3),
                ),
                Row(
                  children: [
                    OtherFeature(selectedIndex: true, text: 'Free Ticket'),
                    SizedBox(
                      width: Adaptive.w(3),
                    ),
                    OtherFeature(selectedIndex: false, text: 'Free Fooding'),
                  ],
                ),
                SizedBox(
                  height: Adaptive.h(1.5),
                ),
                OtherFeature(selectedIndex: false, text: 'Free Visa'),
                SizedBox(
                  height: Adaptive.h(4),
                ),
                Obx(
                  () => jobController.isFiltering.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            jobController.getFilteredJobs(
                                filterCountry, filterJObtype, 'Male', 0.0, 0.0);
                            // if (filterCountry.isEmpty &&
                            //     filterJObtype.isEmpty &&
                            //     jobController.maxSalary == 0.0 &&
                            //     jobController.minSalary == 0.0) {
                            //   Get.snackbar('No filter selected',
                            //       'Pease Select atleast one country or job type or salary range in order to filter jobs');
                            // } else {
                            //   jobController.getFilteredJobs(filterCountry,
                            //       filterJObtype, 'Male', 0.0, 0.0);
                            // }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: Adaptive.h(7),
                            width: Adaptive.w(90),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff00CC9A)),
                            child: Text(
                              'Apply',
                              style: GoogleFonts.plusJakartaSans(
                                  textStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                ),
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

  // Row countryTile() {
  //   return Row(
  //     //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           CheckBoxTile(
  //             text: 'Nepal',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Dubai',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Pakistan',
  //             value: false,
  //           ),
  //         ],
  //       ),
  //       SizedBox(
  //         width: Adaptive.w(12),
  //       ),
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           CheckBoxTile(
  //             text: 'Saudi Arabia',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'USA',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Albania',
  //             value: false,
  //           ),
  //         ],
  //       ),
  //       SizedBox()
  //     ],
  //   );
  // }

  // Row moreCountryTile() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           CheckBoxTile(
  //             text: 'Bahrain',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Croatia',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Cyprus',
  //             value: false,
  //           ),
  //           // CheckBoxTile(
  //           //   text: 'Macau SAR,China',
  //           //   value: false,
  //           // ),
  //           CheckBoxTile(
  //             text: 'Malaysia',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Mauritius',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'UAE',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Russia',
  //             value: false,
  //           ),
  //         ],
  //       ),
  //       SizedBox(
  //         width: Adaptive.w(11),
  //       ),
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           CheckBoxTile(
  //             text: 'Japan',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Jordan',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Kuwait',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Oman',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Qatar',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Romania',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'United Kingdom',
  //             value: false,
  //           ),
  //         ],
  //       ),
  //       SizedBox()
  //     ],
  //   );
  // }

  // Row jonTypeTile() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           CheckBoxTile(
  //             text: 'Cleaning',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Helper',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Hotel & Hospitality',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Labour',
  //             value: false,
  //           ),
  //         ],
  //       ),
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           CheckBoxTile(
  //             text: 'Factory Worker',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Operator',
  //             value: false,
  //           ),
  //           CheckBoxTile(
  //             text: 'Driving',
  //             value: false,
  //           ),
  //         ],
  //       ),
  //       SizedBox()
  //     ],
  //   );
  // }

}

class OtherFeature extends StatefulWidget {
  OtherFeature({super.key, required this.selectedIndex, required this.text});

  bool selectedIndex;
  String text;

  @override
  State<OtherFeature> createState() => _OtherFeatureState();
}

class _OtherFeatureState extends State<OtherFeature> {
  JobController jobController = Get.put(JobController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.selectedIndex) {
            if (widget.text == 'Free Ticket') {
              jobController.otherFeature['free_ticket'] = 'NO';
            }
            if (widget.text == 'Free Fooding') {
              jobController.otherFeature['food_facility'] = 'NO';
            }
            if (widget.text == 'Free Visa') {
              jobController.otherFeature['free_visa'] = 'NO';
            }

            print('map is  ${jobController.otherFeature}');

            widget.selectedIndex = false;
          } else {
            if (widget.text == 'Free Ticket') {
              jobController.otherFeature['free_ticket'] = 'Yes';
            }
            if (widget.text == 'Free Fooding') {
              jobController.otherFeature['food_facility'] = 'Yes';
            }
            if (widget.text == 'Free Visa') {
              jobController.otherFeature['free_visa'] = 'Yes';
            }

            print('map is  ${jobController.otherFeature}');
            widget.selectedIndex = true;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: widget.selectedIndex ? primaryColor : null,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: widget.selectedIndex ? Colors.transparent : lightGrey),
        ),
        child: Text(widget.text,
            style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                    fontSize: Adaptive.px(16),
                    color:
                        widget.selectedIndex ? Colors.white : Colors.black))),
      ),
    );
    ;
  }
}

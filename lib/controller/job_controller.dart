import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/constants.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/model/country_model.dart';
import 'package:job_app/model/job_model.dart';
import 'package:job_app/model/job_type_model.dart';
import 'package:intl/intl.dart';

class JobController extends GetxController {
  RxInt selectedBottomTab = 0.obs;
  int pageSize = 12;
  int pageNumber = 0;
  bool loading = false;
  bool hasMoreItems = true;
  List<JObsModel> jobsList = [];
  List<JObsModel> expireJobList = [];

  String gender = 'Any';

  List<JObsModel> filterJob = [];

  Map<String, String> otherFeature = {
    'food_facility': 'NO',
    'free_ticket': 'Yes',
    'free_visa': 'NO',
  };

  RxBool isfilter = false.obs;

  RxBool showMoreJobType = false.obs;
  RxBool showMoreCountry = false.obs;

  double minSalary = 0.0;
  double maxSalary = 0.0;

  // Rx<List<JObsModel>> jobsList = Rx<List<JObsModel>>([]);
  // List<JObsModel> get getJobsList => jobsList.value;
  final ScrollController scrollController = ScrollController();
  int calculateExpiryDate(String expiryDate) {
    DateTime deadlineDate;
    print('expire date is $expiryDate length is ${expiryDate.length}');
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

    print('differance is ${difference.inDays}');

    return difference.inDays;
  }

  Future<List<JObsModel>> loadMoreItems() async {
    print('============ load more jobs ===========');
    print('=================id is $jobid');
    if (jobsList.isNotEmpty) {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('jobs')
              .orderBy('date_time', descending: false)
              .limit(pageSize)
              .startAfterDocument(await jobsList.last.toDocumentSnapshot(jobid))
              .get();
      final List<JObsModel> newJobsList = snapshot.docs.map((doc) {
        if (calculateExpiryDate(doc['deadline_AD']) < 0) {
          expireJobList.add(JObsModel.fromSnapshot(doc));
        }
        print('expire jobLength is ${expireJobList.length}');
        return JObsModel.fromSnamshot(doc);
      }).toList();

      // final List<JObsModel> newJobsList =
      //     //await filterExpireJObs(snapshot);
      //     snapshot.docs.map((doc) => JObsModel.fromSnamshot(doc)).toList();

      jobsList.addAll(newJobsList);
      loading = false;
      hasMoreItems = newJobsList.length == pageSize;

      update();
      jobid = jobsList.last.jobId!;

      // expiredJObs();

      // setState(() {

      // });

      return jobsList;
    } else {
      print('else call');
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('jobs')
              .orderBy('date_time', descending: false)
              .limit(pageSize)
              .get();
      if (snapshot.docs.isNotEmpty) {
        print('not empty length is ${snapshot.docs.length}');
        final List<JObsModel> newJobsList = snapshot.docs.map((doc) {
          if (calculateExpiryDate(doc['deadline_AD']) < 0) {
            expireJobList.add(JObsModel.fromSnapshot(doc));
          }
          print('expire jobLength is ${expireJobList.length}');
          return JObsModel.fromSnamshot(doc);
        }).toList();

        //  filterExpireJObs(snapshot);
        jobsList.addAll(newJobsList);
        jobid = newJobsList.last.jobId!;

        loading = false;
        hasMoreItems = newJobsList.length == pageSize;
        update();
        //  expiredJObs();
      } else {
        loading = false;
        update();
      }

      return jobsList;

      // setState(() {

      // });
    }
  }

  expiredJObs(JObsModel element) async {
    await FirebaseFirestore.instance
        .collection('expired_jobs')
        .doc(element.jobIdentifier.toString())
        .set({
      'job_identifier': element.jobIdentifier,
      'scrapping_Date': element.scrappingDate,
      'headline': element.headline,
      'country': element.country,
      'job_title': element.jobTitle,
      'job_title_nepali': element.jobTitleNepali,
      'estimated_salary': element.estimatedSalary,
      'expiry_day_remaining': element.expiryDate,
      'deadline_AD': element.deadlineAd,
      'deadline_BS': element.deadlineBS,
      'lot_number': element.lotNumber,
      'sallary': element.sallary,
      'currency': element.currency,
      'employer_Name': element.employerName,
      'employer_location': element.employerLocation,
      'male_quota_approved': element.maleQuotaApproved,
      'female_Quota_approved': element.femaleQuotaApproved,
      'recruiting_agency_name': element.recruitingAgencyName,
      'recruiting_agency_phone_1': element.recruitingAgencyPhone_1,
      'recruiting_agency_phone_2': element.recruitingAgencyPhone_2,
      'recruiting_agency_location': element.recruitingAgencyLocation,
      'location_google_map': element.locationGoogleMap,
      'skill_type': element.skillType,
      'post': element.post,
      'qualification': element.qualification,
      'contract_period_in_years': element.contractPeriodinYears,
      'daily_work_hour': element.dailyWorkHour,
      'weekly_work_day': element.weeklyWorkDay,
      'remaining_days': element.ramainingDays,
      'total_expenses_in_NPR': element.totalExpense,
      'allocated_for_future_1': element.allowcatedForFuture1,
      'allocated_for_future_2': element.allowcatedForFuture2,
      'allocated_for_future_3': element.allowcatedForFuture3,
      'others': element.other,
      'license_No': element.licenseNo,
      "newspaper_details_name": element.newspaperDetailsName,
      'newspaper_details_publish_date': element.newspaperDetailsPublishDate,
      'newspaper_details_link_to_image': element.newsPaperImage,
      'newspaper_details_slogan': element.newspaperDetailsSlogan,
      'food_facility': element.foodFacility,
      'accomodation': element.accomodation,
      'free_visa': element.freeVisa,
      "free_ticket": element.freeTicket,
      'allocated_for_future': element.allowcatedForFuture,
      'link_to_page': element.linkTOPage,
      'employer_email': element.employerEmail,
      'remaining_Male_quota': element.remainMaleQuota,
      'remaining_Female_quota': element.remainningFemaleQuota,
      'date_time': DateTime.now(),
      'country_flag': element.countryFlag
    }).then((value) async {
      FirebaseFirestore.instance
          .collection('jobs')
          .doc(element.jobIdentifier.toString())
          .get()
          .then((value) async {
        if (value.exists) {
          await FirebaseFirestore.instance
              .collection('jobs')
              .doc(element.jobIdentifier.toString())
              .delete();
        }
      });
    });
  }

  String jobid = '-1';

  RxBool isShowJobs = false.obs;
  RxDouble progress = 0.0.obs;

  Rx<String> filePath = ''.obs;
  RxBool isLoading = false.obs;

  RxDouble manProgress = 0.0.obs;

  Rx<String> manFilePath = ''.obs;
  RxBool isManLoading = false.obs;

  RxDouble countryProgress = 0.0.obs;

  Rx<String> countryFilePath = ''.obs;
  RxBool iscountryLoading = false.obs;

  @override
  void onInit() {
    //  getAllJobs();
    // TODO: implement onInit
    super.onInit();
  }

  clearList() {
    Get.put(JobController()).jobsList.clear();
    Get.put(JobController()).update();
  }

  RxBool isFiltering = false.obs;

  Future<void> getFilteredJobs(
      List<String> selectedCountries,
      List<String> selectedJobTypes,
      String selectedGender,
      double minDistance,
      double maxDistance) async {
    print('gender is $gender');
    isfilter.value = true;
    isFiltering.value = true;

    Get.put(JobController()).update();
    // create a reference to the Firestore collection containing the job data
    CollectionReference jobsRef = FirebaseFirestore.instance.collection('jobs');
    Query? countryQuery;
    Query? jobTypeQuery;
    Query? salaryQuery;
    Query? genderQuery;
    // create a query based on the selected countries
    if (selectedCountries.isNotEmpty && selectedJobTypes.isNotEmpty) {
      countryQuery = jobsRef.where('country', whereIn: selectedCountries);
      //  jobTypeQuery = jobsRef.where('job_title', whereIn: selectedJobTypes);

      salaryQuery = jobsRef
          .where('estimated_salary', isGreaterThanOrEqualTo: minSalary)
          .where('estimated_salary', isLessThanOrEqualTo: maxSalary);

      //==================> Geder query
      genderQuery = gender == 'Male'
          ? jobsRef.where('male_quota_approved', isGreaterThan: 0)
          : jobsRef.where('female_Quota_approved', isGreaterThan: 0);
      //==================> Geder query

    } else if (selectedCountries.isNotEmpty && selectedJobTypes.isEmpty) {
      countryQuery = jobsRef.where('country', whereIn: selectedCountries);
      salaryQuery = jobsRef
          .where('estimated_salary', isGreaterThanOrEqualTo: minSalary)
          .where('estimated_salary', isLessThanOrEqualTo: maxSalary);
      //==================> Geder query
      genderQuery = gender == 'Male'
          ? jobsRef.where('male_quota_approved', isGreaterThan: 0)
          : jobsRef.where('female_Quota_approved', isGreaterThan: 0);
      //==================> Geder query
    } else if (selectedCountries.isEmpty && selectedJobTypes.isNotEmpty) {
      jobTypeQuery = jobsRef.where('job_title', whereIn: selectedJobTypes);

      salaryQuery = jobsRef
          .where('estimated_salary', isGreaterThanOrEqualTo: minSalary)
          .where('estimated_salary', isLessThanOrEqualTo: maxSalary);
      //==================> Geder query
      genderQuery = gender == 'Male'
          ? jobsRef.where('male_quota_approved', isGreaterThan: 0)
          : jobsRef.where('female_Quota_approved', isGreaterThan: 0);
      //==================> Geder query
    } else if (selectedCountries.isEmpty && selectedJobTypes.isEmpty) {
      salaryQuery = jobsRef
          .where('estimated_salary', isGreaterThanOrEqualTo: minSalary)
          .where('estimated_salary', isLessThanOrEqualTo: maxSalary);
      //==================> Geder query
      genderQuery = jobsRef.where('male_quota_approved', isNotEqualTo: -1);

      //==================> Geder query
    } else {
      //==================> Geder query
      print('else call');
      genderQuery = jobsRef;
    }
    // execute the queries in parallel using Future.wait
    List<QuerySnapshot>? querySnapshots;

    if (selectedCountries.isNotEmpty && selectedJobTypes.isNotEmpty) {
      querySnapshots = await Future.wait([
        countryQuery!.get(),
        // jobTypeQuery!.get(),
        // genderQuery.get(),
        salaryQuery!.get(),

        // distanceQuery.get(),
      ]);
    } else if (selectedCountries.isNotEmpty && selectedJobTypes.isEmpty) {
      querySnapshots = await Future.wait([
        countryQuery!.get(),

        // genderQuery.get(),
        salaryQuery!.get(),

        // distanceQuery.get(),
      ]);
    } else if (selectedCountries.isEmpty && selectedJobTypes.isNotEmpty) {
      print('==========executed=============');
      querySnapshots = await Future.wait([
        ///   countryQuery!.get(),
        jobTypeQuery!.get(),
        // genderQuery.get(),
        salaryQuery!.get(),

        // distanceQuery.get(),
      ]);
    } else if (selectedCountries.isEmpty && selectedJobTypes.isEmpty) {
      querySnapshots =
          await Future.wait([salaryQuery!.get(), genderQuery.get()]);
    } else {
      querySnapshots = await Future.wait([]);
    }
    // merge the QuerySnapshot objects into a single list of documents
    print('doc length is ${querySnapshots.length}');
    List<DocumentSnapshot> documents = querySnapshots.expand((snap) {
      return snap.docs;
    }).toList();

    print('docsdsdfd length is ${documents.length}');

    // convert the documents to Job objects and return the filtered list of jobs
    documents.map((doc) {
      return JObsModel.fromSnapshot(doc);
    }).toList();

    final List<JObsModel> newJobsList = getnewJobsList(
        documents: documents, selectedJobtypes: selectedJobTypes);

    // final List<JObsModel> newJobsList = documents.map((doc) {
    //   return JObsModel.fromSnapshot(doc);
    // }).toList();

    print('newJobsList job length is ${newJobsList.length}');

    Get.put(JobController()).filterJob = newJobsList;

    isFiltering.value = false;
    Get.back();

    // jobid = newJobsList.last.jobId!;
    // loading = false;
    // hasMoreItems = newJobsList.length == pageSize;
    Get.put(JobController()).update();

    print('filter job length is ${Get.put(JobController()).filterJob.length}');
  }

  List<JObsModel> getnewJobsList(
      {required List<DocumentSnapshot<Object?>> documents,
      List<String>? selectedJobtypes}) {
    print('inner job length ${documents.length}');
    List<JObsModel> myList = [];

    for (var element in documents) {
      print('genderrrrrrrr is $gender');
      if (gender == 'Both' &&
          element['male_quota_approved'] > 0 &&
          element['female_Quota_approved'] > 0) {
        if (selectedJobtypes == null) {
          myList.add(JObsModel.fromSnapshot(element));
        } else {
          for (int i = 0; i < selectedJobtypes.length; i++) {
            if (element['job_title'] == selectedJobtypes[i]) {
              myList.add(JObsModel.fromSnapshot(element));
            }
          }
        }
      } else if (gender == 'Male' && element['male_quota_approved'] > 0) {
        print('2 call');
        if (selectedJobtypes == null) {
          myList.add(JObsModel.fromSnapshot(element));
        } else {
          for (int i = 0; i < selectedJobtypes.length; i++) {
            if (element['job_title'] == selectedJobtypes[i]) {
              myList.add(JObsModel.fromSnapshot(element));
            }
          }
        }
      } else if (gender == 'Female' && element['female_Quota_approved'] > 0) {
        print('3 call');
        if (selectedJobtypes == null) {
          myList.add(JObsModel.fromSnapshot(element));
        } else {
          for (int i = 0; i < selectedJobtypes.length; i++) {
            if (element['job_title'] == selectedJobtypes[i]) {
              myList.add(JObsModel.fromSnapshot(element));
            }
          }
        }
      } else if (gender == 'Any') {
        print('4 call');
        if (selectedJobtypes == null) {
          myList.add(JObsModel.fromSnapshot(element));
        } else {
          for (int i = 0; i < selectedJobtypes.length; i++) {
            if (element['job_title'] == selectedJobtypes[i]) {
              myList.add(JObsModel.fromSnapshot(element));
            }
          }
        }
      }
    }

    return myList;
  }

  // JObsModel checkJObType(
  //     DocumentSnapshot<Object?> element, List<String> selectedJobTypes) {

  //   for (int i = 0; i < selectedJobTypes.length; i++) {

  //   }
  // }

  Rx<List<JobTypeModel>> jobType = Rx<List<JobTypeModel>>([]);
  List<JobTypeModel> get getJobType => jobType.value;

  getJobsType() {
    jobType.bindStream(getJobsTypeStream());
  }

  Stream<List<JobTypeModel>> getJobsTypeStream() {
    return FirebaseFirestore.instance
        .collection('job_type')
        .orderBy('frequency', descending: true)
        .limit(100)
        .snapshots()
        .map((event) {
      List<JobTypeModel> retVal = [];
      for (var element in event.docs) {
        retVal.add(JobTypeModel.fromSnamshot(element));
      }
      print('Jobs list  Length is ${retVal.length}');
      return retVal;
    });
  }

  Rx<List<CountryModel>> countryList = Rx<List<CountryModel>>([]);
  List<CountryModel> get getcountryList => countryList.value;

  getCountries() {
    countryList.bindStream(getCountryStream());
  }

  Stream<List<CountryModel>> getCountryStream() {
    return FirebaseFirestore.instance
        .collection('country')
        .orderBy('frequency', descending: true)
        .limit(100)
        .snapshots()
        .map((event) {
      List<CountryModel> retVal = [];
      for (var element in event.docs) {
        retVal.add(CountryModel.fromSnamshot(element));
      }
      print('country list  Length is ${retVal.length}');
      return retVal;
    });
  }

  Rx<JObsModel> shareJobData = JObsModel().obs;

  JObsModel get getShareData => shareJobData.value;
  set getShareData(JObsModel value) => shareJobData.value = value;

  Future getShareJobData(String jobId) async {
    try {
      var doc =
          await FirebaseFirestore.instance.collection("jobs").doc(jobId).get();
      shareJobData.value = JObsModel.fromSnamshot(doc);
      print(
          'job id is ${getShareData.jobTitle} job title ${getShareData.jobTitle}');
    } catch (e) {
      print('error is ${e.toString()}');
    }
  }

  AuthcController authcController = Get.put(AuthcController());

  Future saveJOb(JObsModel element) async {
    Get.back();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authcController.auth.currentUser!.uid)
        .collection('savedJobs')
        .doc(element.jobId)
        .set({
      'job_identifier': element.jobIdentifier,
      'scrapping_Date': element.scrappingDate,
      'headline': element.headline,
      'headline_nepali': element.headlineNepali,
      'country': element.country,
      'country_nepali': element.countryNepali,
      'job_title': element.jobTitle,
      'job_title_nepali': element.jobTitleNepali,
      'estimated_salary': element.estimatedSalary,
      'expiry_day_remaining': element.expiryDate,
      'deadline_AD': element.deadlineAd,
      'deadline_BS': element.deadlineBS,
      'lot_number': element.lotNumber,
      'sallary': element.sallary,
      'currency': element.currency,
      'employer_Name': element.employerName,
      'employer_location': element.employerLocation,
      'male_quota_approved': element.maleQuotaApproved,
      'female_Quota_approved': element.femaleQuotaApproved,
      'recruiting_agency_name': element.recruitingAgencyName,
      'recruiting_agency_name_nepali': element.recruitingAgencyLocationNepali,
      'recruiting_agency_phone_1': element.recruitingAgencyPhone_1,
      'recruiting_agency_phone_2': element.recruitingAgencyPhone_2,
      'recruiting_agency_location': element.recruitingAgencyLocation,
      'recruiting_agency_location_nepali':
          element.recruitingAgencyLocationNepali,
      'location_google_map': element.locationGoogleMap,
      'skill_type': element.skillType,
      'skill_type_nepali': element.skillTypeNepali,
      'post': element.post,
      'qualification': element.qualification,
      'qualification_nepali': element.qualificationNepali,
      'contract_period_in_years': element.contractPeriodinYears,
      'daily_work_hour': element.dailyWorkHour,
      'weekly_work_day': element.weeklyWorkDay,
      'remaining_days': element.ramainingDays,
      'total_expenses_in_NPR': element.totalExpense,
      'allocated_for_future_1': element.allowcatedForFuture1,
      'allocated_for_future_2': element.allowcatedForFuture2,
      'allocated_for_future_3': element.allowcatedForFuture3,
      'others': element.other,
      'license_No': element.licenseNo,
      "newspaper_details_name": element.newspaperDetailsName,
      'newspaper_details_publish_date': element.newspaperDetailsPublishDate,
      'newspaper_details_link_to_image': element.newsPaperImage,
      'newspaper_details_slogan': element.newspaperDetailsSlogan,
      'food_facility': element.foodFacility,
      'accomodation': element.accomodation,
      'free_visa': element.freeVisa,
      "free_ticket": element.freeTicket,
      'allocated_for_future': element.allowcatedForFuture,
      'link_to_page': element.linkTOPage,
      'employer_email': element.employerEmail,
      'remaining_Male_quota': element.remainMaleQuota,
      'remaining_Female_quota': element.remainningFemaleQuota,
      'date_time': DateTime.now(),
      'country_flag': element.countryFlag,
      'messenger': element.messangerLink,
      'whastappLink': element.whatsappLink,
    }).then((value) async {
      savedJobsId.add(element.jobIdentifier!.toString());
      update();
      Get.snackbar('JOB SAVED', 'Job saved successfully',
          colorText: Colors.white, backgroundColor: primaryColor);
    });
  }

  Future<void> removeFromSavedJobs(JObsModel element) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authcController.auth.currentUser!.uid)
        .collection('savedJobs')
        .doc(element.jobId)
        .delete()
        .then((value) {
      Get.back();
    });
  }

  Rx<List<JObsModel>> savedJobs = Rx<List<JObsModel>>([]);
  List<JObsModel> get getSavedJobsList => savedJobs.value;
  getAllSavedJobs() {
    savedJobs.bindStream(getSavedJobsStream());
    //  savedJobsId.bindStream(getSavedJobsIdStream());
  }

  List<String> savedJobsId = [];

  Stream<List<JObsModel>> getSavedJobsStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authcController.auth.currentUser!.uid)
        .collection('savedJobs')
        .orderBy('date_time', descending: false)
        .snapshots()
        .map((event) {
      List<JObsModel> retVal = [];
      for (var element in event.docs) {
        savedJobsId.add(element.id);

        retVal.add(JObsModel.fromSnamshot(element));
      }
      update();
      print('saves jobs list  Length is ${retVal.length}');
      return retVal;
    });
  }

  Stream<List<String>> getSavedJobsIdStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(authcController.auth.currentUser!.uid)
        .collection('savedJobsId')
        .snapshots()
        .map((event) {
      List<String> retVal = [];
      for (var element in event.docs) {
        retVal.add(element['jobId']);
      }
      return retVal;
    });
  }
}

import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:job_app/model/country_model.dart';
import 'package:job_app/model/job_model.dart';
import 'package:job_app/model/job_type_model.dart';

class JobController extends GetxController {
  RxInt selectedBottomTab = 0.obs;
  int pageSize = 20;
  int pageNumber = 0;
  bool loading = false;
  bool hasMoreItems = true;
  List<JObsModel> jobsList = [];

  String gender = 'Male';

  List<JObsModel> filterJob = [];

  int filterPageSize = 20;
  int filterPageNumber = 0;
  bool filterLoading = false;
  bool filterJasMoreItems = true;

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

  final ScrollController scrollController = ScrollController();

  Future<List<JObsModel>> loadMoreItems() async {
    if (jobsList.isNotEmpty) {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('jobs')
              .orderBy('date_time', descending: false)
              .limit(pageSize)
              .startAfterDocument(await jobsList.last.toDocumentSnapshot(jobid))
              .get();
      final List<JObsModel> newJobsList =
          snapshot.docs.map((doc) => JObsModel.fromSnamshot(doc)).toList();
      jobid = newJobsList.last.jobId!;
      jobsList.addAll(newJobsList);
      loading = false;
      hasMoreItems = newJobsList.length == pageSize;
      update();

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
        final List<JObsModel> newJobsList =
            snapshot.docs.map((doc) => JObsModel.fromSnamshot(doc)).toList();
        jobid = newJobsList.last.jobId!;
        jobsList.addAll(newJobsList);
        loading = false;
        hasMoreItems = newJobsList.length == pageSize;
        update();
      } else {
        loading = false;
        update();
      }

      return jobsList;
    }
  }

  String jobid = '-1';

  RxBool isShowJobs = false.obs;
  RxDouble progress = 0.0.obs;

  Rx<String> filePath = ''.obs;
  RxBool isLoading = false.obs;

  RxDouble manProgress = 0.0.obs;

  Rx<String> manFilePath = ''.obs;
  RxBool isManLoading = false.obs;

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
    CollectionReference jobsRef = FirebaseFirestore.instance.collection('jobs');
    Query? countryQuery;
    Query? jobTypeQuery;
    Query? salaryQuery;
    Query? genderQuery;
    // create a query based on the selected countries
    if (selectedCountries.isNotEmpty && selectedJobTypes.isNotEmpty) {
      countryQuery = jobsRef.where('country', whereIn: selectedCountries);
      jobTypeQuery =
          jobsRef.where('job_title_english', whereIn: selectedJobTypes);

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
      jobTypeQuery =
          jobsRef.where('job_title_english', whereIn: selectedJobTypes);

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
      genderQuery = gender == 'Male'
          ? jobsRef.where('male_quota_approved', isGreaterThan: 0)
          : jobsRef.where('female_Quota_approved', isGreaterThan: 0);
      //==================> Geder query
    } else {
      //==================> Geder query
      print('else call');
      genderQuery = gender == 'Male'
          ? jobsRef.where('male_quota_approved', isGreaterThan: 0)
          : jobsRef.where('female_Quota_approved', isGreaterThan: 0);
      //==================> Geder query
    }
    List<QuerySnapshot>? querySnapshots;

    if (selectedCountries.isNotEmpty && selectedJobTypes.isNotEmpty) {
      querySnapshots = await Future.wait([
        countryQuery!.get(),
        jobTypeQuery!.get(),
        // genderQuery.get(),
        salaryQuery!.get(),
        genderQuery.get(),
        // distanceQuery.get(),
      ]);
    } else if (selectedCountries.isNotEmpty && selectedJobTypes.isEmpty) {
      querySnapshots = await Future.wait([
        countryQuery!.get(),

        // genderQuery.get(),
        salaryQuery!.get(),
        genderQuery.get(),

        // distanceQuery.get(),
      ]);
    } else if (selectedCountries.isEmpty && selectedJobTypes.isNotEmpty) {
      querySnapshots = await Future.wait([
        ///   countryQuery!.get(),
        jobTypeQuery!.get(),
        // genderQuery.get(),
        salaryQuery!.get(),
        genderQuery.get(),

        // distanceQuery.get(),
      ]);
    } else if (selectedCountries.isEmpty && selectedJobTypes.isEmpty) {
      querySnapshots = await Future.wait([
        salaryQuery!.get(),
        genderQuery.get(),
      ]);
    } else {
      querySnapshots = await Future.wait([
        genderQuery.get(),
      ]);
    }
    List<DocumentSnapshot> documents =
        querySnapshots.expand((snap) => snap.docs).toList();

    documents.map((doc) => JObsModel.fromSnapshot(doc)).toList();

    final List<JObsModel> newJobsList =
        documents.map((doc) => JObsModel.fromSnapshot(doc)).toList();

    print('newJobsList job length is ${newJobsList.length}');

    Get.put(JobController()).filterJob = newJobsList;

    isFiltering.value = false;
    Get.back();
    Get.put(JobController()).update();

    print('filter job length is ${Get.put(JobController()).filterJob.length}');
  }

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
}

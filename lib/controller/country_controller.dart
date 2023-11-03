import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:job_app/model/country_model.dart';
import 'package:job_app/model/job_model.dart';
import 'package:intl/intl.dart';

class CountryController extends GetxController {
  @override
  void onInit() {
    getCountries();

    super.onInit();
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

  //===================== Get country jobs =====================
  int pageSize = 12;
  int pageNumber = 0;
  bool loading = false;
  bool hasMoreItems = true;
  String jobid = '-1';
  final ScrollController scrollController = ScrollController();

  // Rx<List<JObsModel>> countryJobs = Rx<List<JObsModel>>([]);
  // List<JObsModel> get getcountryJobs => countryJobs.value;
  List<JObsModel> countryJobs = [];
  Future<List<JObsModel>> oadMoreItems(String countryId) async {
    print('============ load more jobs ===========');
    if (countryJobs.isNotEmpty) {
      print('job id is $jobid');
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('country')
              .doc(countryId)
              .collection('jobs')
              .limit(pageSize)
              .startAfterDocument(
                  await countryJobs.last.toDocumentSnapshot(jobid))
              .get();
      final List<JObsModel> newJobsList = snapshot.docs.map((doc) {
        if (calculateExpiryDate(doc['deadline_AD']) < 0) {}
        return JObsModel.fromSnamshot(doc);
      }).toList();

      // final List<JObsModel> newJobsList =
      //     //await filterExpireJObs(snapshot);
      //     snapshot.docs.map((doc) => JObsModel.fromSnamshot(doc)).toList();

      countryJobs.addAll(newJobsList);
      loading = false;
      hasMoreItems = countryJobs.length == pageSize;

      update();
      jobid = newJobsList.last.jobId!;

      // setState(() {

      // });

      return countryJobs;
    } else {
      print('else call');
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('country')
              .doc(countryId)
              .collection('jobs')
              .orderBy('date_time', descending: false)
              .limit(pageSize)
              .get();
      if (snapshot.docs.isNotEmpty) {
        print('not empty length is ${snapshot.docs.length}');
        final List<JObsModel> newJobsList = snapshot.docs.map((doc) {
          if (calculateExpiryDate(doc['deadline_AD']) < 0) {}

          return JObsModel.fromSnamshot(doc);
        }).toList();

        //  filterExpireJObs(snapshot);
        jobid = newJobsList.last.jobId!;
        countryJobs.addAll(newJobsList);

        loading = false;
        hasMoreItems = newJobsList.length == pageSize;
        update();
      } else {
        loading = false;
        update();
      }

      return countryJobs;

      // setState(() {

      // });
    }
  }

  // getCountriesJobs(String countryId) {
  //   countryJobs.bindStream(getCountryJObsStream(countryId));
  // }

  // Stream<List<JObsModel>> getCountryJObsStream(String countryId) {
  //   return FirebaseFirestore.instance
  //       .collection('country')
  //       .doc(countryId)
  //       .collection('jobs')
  //       .orderBy('date_time', descending: false)
  //       .snapshots()
  //       .map((event) {
  //     List<JObsModel> retVal = [];
  //     for (var element in event.docs) {
  //       if (calculateExpiryDate(element['deadline_AD']) < 0) {
  //       } else {
  //         retVal.add(JObsModel.fromSnamshot(element));
  //       }
  //     }
  //     print('jobs list  Length is ${retVal.length}');
  //     updateJobFrequency(countryId, retVal.length);
  //     return retVal;
  //   });
  // }

  updateJobFrequency(String coutnryId, int totalJobs) async {
    await FirebaseFirestore.instance
        .collection('country')
        .doc(coutnryId)
        .update({'frequency': totalJobs}).then((value) {
      print('update $coutnryId');
    });
  }

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

  Rx<String> aboutCountry = ''.obs;

  String get getaboutCountry => aboutCountry.value;
  set getShareData(String value) => aboutCountry.value = value;

  Future getAboutCountyrData(String countryId) async {
    print('country id is $countryId');
    try {
      var doc = await FirebaseFirestore.instance
          .collection("country_info")
          .doc(countryId.toLowerCase())
          .get();
      print('${doc['about']}');
      aboutCountry.value = doc['about'];
    } catch (e) {
      print('error is ${e.toString()}');
    }
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:job_app/model/job_model.dart';
import 'package:job_app/model/man_power_detail.dart';

class ManPowerController extends GetxController {
  int pageSize = 20;
  int pageNumber = 0;
  bool loading = false;
  bool hasMoreItems = true;
  List<ManPowerDetail> manList = [];
  final ScrollController scrollController = ScrollController();

  Future<void> loadMoreItems() async {
    if (manList.isNotEmpty) {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('manpower')
              .orderBy('manpower_name', descending: false)
              .limit(pageSize)
              .startAfterDocument(await manList.last.toDocumentSnapshot(jobid))
              .get();
      final List<ManPowerDetail> newJobsList =
          snapshot.docs.map((doc) => ManPowerDetail.fromSnamshot(doc)).toList();
      jobid = newJobsList.last.manId!;
      manList.addAll(newJobsList);
      loading = false;
      hasMoreItems = newJobsList.length == pageSize;
      log(' if has more item is $hasMoreItems');
      update();

      // setState(() {

      // });
    } else {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('manpower')
              .orderBy('manpower_name', descending: false)
              .limit(pageSize)
              .get();
      if (snapshot.docs.isNotEmpty) {
        final List<ManPowerDetail> newJobsList = snapshot.docs
            .map((doc) => ManPowerDetail.fromSnamshot(doc))
            .toList();

        jobid = newJobsList.last.manId!;
        manList.addAll(newJobsList);
        loading = false;
        hasMoreItems = newJobsList.length == pageSize;
        log('else has more item is $hasMoreItems');

        update();
      } else {
        loading = false;
        update();
      }
      // setState(() {

      // });
    }
  }

  String jobid = '-1';

  Rx<ManPowerDetail> manPowerDetail = ManPowerDetail().obs;

  ManPowerDetail get getManPowerData => manPowerDetail.value;
  set getManPowerData(ManPowerDetail value) => manPowerDetail.value = value;
  RxBool isDataExists = false.obs;
  Future getManPowerDetail(String id) async {
    await FirebaseFirestore.instance
        .collection("manpower")
        .doc(id.replaceAll('/', "_"))
        .get()
        .then((value) {
      if (value.exists) {
        manPowerDetail.value = ManPowerDetail.fromSnamshot(value);
        isDataExists.value = true;
      } else {
        isDataExists.value = false;
      }
    });
    // try {

    // } catch (e) {
    //   print('error is ${e.toString()}');
    // }
  }

  Rx<List<JObsModel>> jobsList = Rx<List<JObsModel>>([]);
  List<JObsModel> get getJobsList => jobsList.value;

  getAgentJobs(String licenceNo) {
    jobsList.bindStream(getAgentJobsStream(licenceNo));
  }

  Stream<List<JObsModel>> getAgentJobsStream(String licenceNo) {
    print('licence at func no is $licenceNo ');
    return FirebaseFirestore.instance
        .collection('jobs')
        .where('license_No', isEqualTo: licenceNo)
        .snapshots()
        .map((event) {
      List<JObsModel> retVal = [];
      for (var element in event.docs) {
        retVal.add(JObsModel.fromSnamshot(element));
      }
      log('Jobs list  Length is ${retVal.length}');
      return retVal;
    });
  }

  Rx<ManPowerDetail> agentData = ManPowerDetail().obs;

  ManPowerDetail get getAgentData => agentData.value;
  set getAgentData(ManPowerDetail value) => agentData.value = value;

  Future getAgent(String id) async {
    await FirebaseFirestore.instance
        .collection("manpower")
        .doc(id.replaceAll('/', "_"))
        .get()
        .then((value) {
      if (value.exists) {
        agentData.value = ManPowerDetail.fromSnamshot(value);
      }
    });
  }
}

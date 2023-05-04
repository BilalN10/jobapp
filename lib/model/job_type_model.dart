import 'package:cloud_firestore/cloud_firestore.dart';

class JobTypeModel {
  String? jobTile;
  int? frequency;
  bool? value = false;

  JobTypeModel({this.frequency, this.jobTile, this.value});

  JobTypeModel.fromSnamshot(DocumentSnapshot<Map<String, dynamic>> data) {
    jobTile = data.data()!["job_type"];
    frequency = data.data()!["frequency"];
  }
}

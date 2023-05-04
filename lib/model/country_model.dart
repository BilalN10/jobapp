import 'package:cloud_firestore/cloud_firestore.dart';

class CountryModel {
  String? countryName;
  bool? value = false;
  int? frequency;

  CountryModel({this.countryName, this.value, this.frequency});

  CountryModel.fromSnamshot(DocumentSnapshot<Map<String, dynamic>> data) {
    countryName = data.data()!["country_name"];
    frequency = data.data()!["frequency"];
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class CountryModel {
  String? countryName;
  bool? value = false;
  int? frequency;
  String? countryFlag;
  String? countryId;

  CountryModel(
      {this.countryName,
      this.value,
      this.frequency,
      this.countryFlag,
      this.countryId});

  CountryModel.fromSnamshot(DocumentSnapshot<Map<String, dynamic>> data) {
    countryId = data.id;
    countryName = data.data()!["country_name"];
    frequency = data.data()!["frequency"];
    countryFlag = data.data()!['country_flag'];
  }
}

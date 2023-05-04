import 'package:cloud_firestore/cloud_firestore.dart';

class ManPowerDetail {
  String? licenseNo;
  String? about;
  String? facebookLinkPage;
  String? googleMap;
  String? iconLink;
  String? location;
  String? manager;
  String? manpowerName;
  String? phone_1;
  String? phone_2;
  String? phone_3;

  String? photoLink;
  String? status;
  String? manId;

  ManPowerDetail(
      {this.about,
      this.facebookLinkPage,
      this.googleMap,
      this.iconLink,
      this.licenseNo,
      this.location,
      this.manager,
      this.manpowerName,
      this.phone_1,
      this.phone_2,
      this.phone_3,
      this.photoLink,
      this.status,
      this.manId});

  ManPowerDetail.fromSnamshot(DocumentSnapshot<Map<String, dynamic>> data) {
    manId = data.id;
    licenseNo = data.data()!["License_no"].toString() == 'null'
        ? '----'
        : data.data()!["License_no"].toString();
    about = data.data()!["about"].toString() == 'null'
        ? '----'
        : data.data()!["about"].toString();
    facebookLinkPage = data.data()!["facebook_page_link"].toString() == 'null'
        ? '----'
        : data.data()!["facebook_page_link"].toString();
    googleMap = data.data()!["google_map"].toString() == 'null'
        ? '----'
        : data.data()!["google_map"].toString();
    iconLink = data.data()!["icon_link"].toString() == 'null'
        ? '----'
        : data.data()!["icon_link"].toString();
    location = data.data()!["location"].toString() == 'null'
        ? '----'
        : data.data()!["location"].toString();
    manager = data.data()!["manager"].toString() == 'null'
        ? '----'
        : data.data()!["manager"].toString();
    manpowerName = data.data()!["manpower_name"].toString() == 'null'
        ? '----'
        : data.data()!["manpower_name"].toString();
    phone_1 = data.data()!["phone_1"].toString() == 'null'
        ? '----'
        : data.data()!["phone_1"].toString();
    phone_2 = data.data()!["phone_3"].toString() == 'null'
        ? '----'
        : data.data()!["phone_3"].toString();
    phone_3 = data.data()!["phone_3"].toString() == 'null'
        ? '----'
        : data.data()!["phone_3"].toString();

    status = data.data()!["status"].toString() == 'null'
        ? '----'
        : data.data()!["status"].toString();

    print('licence no is ${licenseNo}');
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> toDocumentSnapshot(
      String jobId) async {
    final document = await FirebaseFirestore.instance
        .collection('manpower')
        .doc(jobId)
        .get();
    return document;
  }
}

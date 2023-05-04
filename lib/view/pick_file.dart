import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:job_app/controller/job_controller.dart';
import 'package:job_app/view/constants/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class MyCSVUploader extends StatefulWidget {
  @override
  _MyCSVUploaderState createState() => _MyCSVUploaderState();
}

class _MyCSVUploaderState extends State<MyCSVUploader> {
  String? _fileName;
  List<List<dynamic>>? _rows;

  @override
  void initState() {
    jobController.filePath.value = '';
    jobController.isLoading.value = false;
    jobController.progress.value = 0.0;

    jobController.manFilePath.value = '';
    jobController.isManLoading.value = false;
    jobController.manProgress.value = 0.0;
    // TODO: implement initState
    super.initState();
  }

  JobController jobController = Get.put(JobController());

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xls', 'xlsx'],
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      final bytes = await file.readAsBytes();
      final decoder = SpreadsheetDecoder.decodeBytes(bytes);
      final sheet = decoder.tables[decoder.tables.keys.first];
      setState(() {
        _fileName = result.files.single.name;
        _rows = sheet!.rows;
        jobController.filePath.value = result.files.single.path!;
      });
      //  await _uploadToFirestore();
    } else {
      // User canceled the picker
    }
  }

  Map<String, String> countryFlags = {
    'ALBANIA': 'assets/icons/ALBANIA.svg',
    'Bahrain': 'assets/icons/Bahrain.svg',
    'Croatia': 'assets/icons/Croatia.svg',
    'Cyprus': 'assets/icons/Cyprus.svg',
    'Japan': 'assets/icons/Japan.svg',
    'Jordan': 'assets/icons/Jordan.svg',
    'Kuwait': 'assets/icons/Kuwait.svg',
    'Macau SAR,China': 'assets/icons/Macau SAR,China.svg',
    'Malaysia': 'assets/icons/Malaysia.svg',
    'Mauritius': 'assets/icons/Mauritius.svg',
    'Oman': 'assets/icons/Oman.svg',
    'Qatar': 'assets/icons/Qatar.svg',
    'Romania': 'assets/icons/Romania.svg',
    'Russia': 'assets/icons/Russia.svg',
    'Saudi Arabia': 'assets/icons/Saudi Arabia.svg',
    'UAE': 'assets/icons/UAE.svg',
    'United Kingdom': 'assets/icons/United Kingdom.svg',
  };

  Future<void> _uploadToFirestore() async {
    jobController.isLoading.value = true;
    jobController.progress.value = 0.0;

    if (_rows == null) return;
    final data = _rows!
        .skip(1)
        .map((row) => {
              'job_identifier': row[1],
              'scrapping_Date': row[2],
              'headline': row[3],
              'country': row[5],
              'job_title': row[6],
              'job_title_english': row[7],
              'estimated_salary': row[8],
              'expiry_day_remaining': row[9],
              'deadline_AD': row[10],
              'deadline_BS': row[11],
              'lot_number': row[12],
              'sallary': row[13],
              'currency': row[14],
              'employer_Name': row[15],
              'employer_location': row[16],
              'male_quota_approved': row[17],
              'female_Quota_approved': row[18],
              'recruiting_agency_name': row[19],
              'recruiting_agency_phone_1': row[20],
              'recruiting_agency_phone_2': row[21],
              'recruiting_agency_location': row[22],
              'location_google_map': row[23],
              'skill_type': row[25],
              'post': row[26],
              'qualification': row[27],
              'contract_period_in_years': row[28],
              'daily_work_hour': row[29],
              'weekly_work_day': row[30],
              'remaining_days': row[31],
              'total_expenses_in_NPR': row[32],
              'allocated_for_future_1': row[33],
              'allocated_for_future_2': row[34],
              'allocated_for_future_3': row[35],
              'others': row[36],
              'license_No': row[37],
              "newspaper_details_name": row[38],
              'newspaper_details_publish_date': row[39],
              'newspaper_details_link_to_image': row[40],
              'newspaper_details_slogan': row[41],
              'food_facility': row[42],
              'accomodation': row[43],
              'free_visa': row[44],
              "free_ticket": row[45],
              'allocated_for_future': row[46],
              'link_to_page': row[47],
              'employer_email': row[48],
              'remaining_Male_quota': row[49],
              'remaining_Female_quota': row[50],
              'date_time': DateTime.now(),
              'country_flag': countryFlags[row[5]]
            })
        .toList();

    final totalRows = data.length;
    var uploadedRows = 0;

    // log('data is $data');
    for (int i = 0; i < data.length; i++) {
      log('i  is $i');

      log('data length is ${data.length}');
      //  print(data[i]);

      await FirebaseFirestore.instance
          .collection('jobs')
          .doc(data[i]['job_identifier'].toString())
          .set(data[i]);

      await FirebaseFirestore.instance
          .collection('country')
          .doc(data[i]['country'].toLowerCase().replaceAll(' ', '_').trim())
          .get()
          .then((value) {
        if (value.exists) {
          FirebaseFirestore.instance
              .collection('country')
              .doc(data[i]['country'].toLowerCase().replaceAll(' ', '_').trim())
              .update({'frequency': value['frequency'] + 1}).then((value) {
            print('update');
          });
        } else {
          FirebaseFirestore.instance
              .collection('country')
              .doc(data[i]['country'].toLowerCase().replaceAll(' ', '_').trim())
              .set({'country_name': data[i]['country'], 'frequency': 1}).then(
                  (value) {
            print('add');
          });
        }
      });

      // addcountry(data[i]['country']).then((value) {
      // });
      uploadedRows++;
      final newProgress = uploadedRows / totalRows;
      jobController.progress.value = newProgress;

      // addJobType(data[i]['job_title_english']);

    }
    Get.snackbar('File Uploaded', 'File Uploaded successfully');
    jobController.isLoading.value = false;
    jobController.filePath.value = '';
  }
//Construction Carpenter

  void addJobType(String jobTypeId) {
    log('path is ${jobTypeId.toLowerCase().replaceAll(' ', '_').trim()}');
    FirebaseFirestore.instance
        .collection('job_type')
        .doc(jobTypeId.toLowerCase().replaceAll(' ', '_').trim())
        .get()
        .then((value) {
      if (value.exists) {
        FirebaseFirestore.instance
            .collection('job_type')
            .doc(jobTypeId.toLowerCase().replaceAll(' ', '_').trim())
            .update({'frequency': value['frequency'] + 1}).then((value) {
          print('update');
        });
      } else {
        FirebaseFirestore.instance
            .collection('job_type')
            .doc(jobTypeId.toLowerCase().replaceAll(' ', '_').trim())
            .set({'job_type': jobTypeId, 'frequency': 1}).then((value) {
          print('add');
        });
      }
    });
  }

  Future addcountry(String countryId) async {
    log('path is ${countryId.toLowerCase().replaceAll(' ', '_').trim()}');
    await FirebaseFirestore.instance
        .collection('country')
        .doc(countryId.toLowerCase().replaceAll(' ', '_').trim())
        .get()
        .then((value) {
      if (value.exists) {
        FirebaseFirestore.instance
            .collection('country')
            .doc(countryId.toLowerCase().replaceAll(' ', '_').trim())
            .update({'frequency': value['frequency'] + 1}).then((value) {
          print('update');
        });
      } else {
        FirebaseFirestore.instance
            .collection('country')
            .doc(countryId.toLowerCase().replaceAll(' ', '_').trim())
            .set({'country_name': countryId, 'frequency': 1}).then((value) {
          print('add');
        });
      }
    });
  }

  String? _manfileName;
  List<List<dynamic>>? manrows;

  void pickManFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xls', 'xlsx'],
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      final bytes = await file.readAsBytes();
      final decoder = SpreadsheetDecoder.decodeBytes(bytes);
      final sheet = decoder.tables[decoder.tables.keys.first];
      setState(() {
        _manfileName = result.files.single.name;
        manrows = sheet!.rows;
        jobController.manFilePath.value = result.files.single.path!;
      });
      //  await _uploadToFirestore();
    } else {
      // User canceled the picker
    }
  }

  Future<void> _uploadManPwerToFirestore() async {
    jobController.isManLoading.value = true;
    jobController.manProgress.value = 0.0;

    if (manrows == null) return;
    final data = manrows!
        .skip(1)
        .map((row) => {
              'License_no': row[1],
              'manpower_name': row[2],
              'location': row[3],
              'phone_1': row[4],
              'phone_2': row[5],
              'phone_3': row[6],
              'google_map': row[7],
              'about': row[8],
              'icon_link': row[9],
              'photo_link': row[10],
              'facebook_page_link': row[11],
              'manager': row[12],
              'status': row[13],
            })
        .toList();

    final totalRows = data.length;
    var uploadedRows = 0;

    // log('data is $data');
    for (int i = 0; i < data.length; i++) {
      print(data[i]);

      await FirebaseFirestore.instance
          .collection('manpower')
          .doc(data[i]['License_no'].toString().replaceAll('/', '_'))
          .set(data[i]);
      uploadedRows++;
      final newProgress = uploadedRows / totalRows;
      jobController.manProgress.value = newProgress;
    }
    Get.snackbar('File Uploaded', 'File Uploaded successfully');
    jobController.isManLoading.value = false;
    jobController.manFilePath.value = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_new_outlined),
        centerTitle: true,
        backgroundColor: primaryColor,
        title: const Text('Upload CSV File'),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (jobController.isLoading.value)
                Column(
                  children: [
                    const CircularProgressIndicator(
                      color: primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                        '${(jobController.progress.value * 100).toStringAsFixed(1)}%'),
                    LinearProgressIndicator(
                        color: primaryColor,
                        backgroundColor: lightGrey,
                        value: jobController.progress.value),
                  ],
                )
              else if (jobController.filePath.value.isNotEmpty)
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      return primaryColor;
                    }),
                  ),
                  onPressed: _uploadToFirestore,
                  child: const Text('Upload Jobs Data to Firestore'),
                )
              else
                SizedBox(
                  width: Adaptive.w(80),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        return primaryColor;
                      }),
                    ),
                    onPressed: _pickFile,
                    child: const Text('Pick a Excel File for Jobs'),
                  ),
                ),
              // for manpower
              SizedBox(
                height: Adaptive.h(5),
              ),

              if (jobController.isManLoading.value)
                Column(
                  children: [
                    const CircularProgressIndicator(
                      color: primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                        '${(jobController.manProgress.value * 100).toStringAsFixed(1)}%'),
                    LinearProgressIndicator(
                        color: primaryColor,
                        backgroundColor: lightGrey,
                        value: jobController.manProgress.value),
                  ],
                )
              else if (jobController.manFilePath.value.isNotEmpty)
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      return primaryColor;
                    }),
                  ),
                  onPressed: _uploadManPwerToFirestore,
                  child: const Text('Upload ManPower Data to Firestore'),
                )
              else
                SizedBox(
                  width: Adaptive.w(80),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        return primaryColor;
                      }),
                    ),
                    onPressed: pickManFile,
                    child: const Text('Pick a Excel File for Man Power'),
                  ),
                ),
            ],
          ),
        ),
      )),
    );
  }
}

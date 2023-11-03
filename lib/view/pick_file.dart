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
import 'package:job_app/constants/constants.dart';
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

    jobController.countryFilePath.value = '';
    jobController.iscountryLoading.value = false;
    jobController.countryProgress.value = 0.0;
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
              'date_time': DateTime.now(),
              'lot_number': row[0], //a
              'job_identifier': row[1], //b
              'headline': row[2], //c  //'scrapping_Date': row[2],
              'headline_nepali': row[3], //d
              'country': row[4], //e
              'country_nepali': row[5], //f  new
              'job_title': row[6], //g
              'job_title_nepali': row[7], //h   new
              'skill_type': row[8], //I
              'skill_type_nepali': row[9], //J  new
              'industry': row[10], //k   new
              'industry_nepali': row[11], //l   new
              'sallary': row[12], //m
              'currency': row[13], //n
              'estimated_salary': row[14], //O
              'deadline_AD': row[15], //p
              'deadline_BS': row[16], //q
              'male_quota_approved': row[17], //r
              'female_Quota_approved': row[18], //s
              'qualification': row[19], //t
              'qualification_nepali': row[20], //u  new
              'contract_period_in_years': row[21], //v
              'daily_work_hour': row[22], //w
              'weekly_work_day': row[23], //x
              'food_facility': row[24], // y
              'accomodation': row[25], //z
              'free_visa': row[26], //AA
              "free_ticket": row[27], //AB
              'others': row[28], //AC
              'total_expenses_in_NPR': row[29], //AD
              "lot_approved_date": row[30], //AE
              'allocated_for_future_1': row[31], //AF
              'allocated_for_future_2': row[32], //AG
              'allocated_for_future_3': row[33], //AH
              'employer_Name': row[34], //AI
              'employer_Name_nepali': row[35], //AJ            new
              'employer_location': row[36], //AK
              'employer_location_nepali': row[37], //AL    new
              'employer_email': row[38], //AM
              'employer_detail': row[39], //AN
              'recruiting_agency_name': row[43], //AR
              'recruiting_agency_name_nepali': row[44], //AS      new
              'recruiting_agency_location': row[45], //AT
              'recruiting_agency_location_nepali': row[46], //AU      new
              'location_google_map': row[47], //AV
              'recruiting_agency_phone_1': row[48], //AW
              'recruiting_agency_phone_2': row[49], //AX
              'whastappLink': row[50], //AY             new
              'messenger': row[51], //AZ                  new
              'license_No': row[52], //BA
              "newspaper_details_name": row[56], //BE
              'newspaper_details_publish_date': row[57], //BF
              'newspaper_details_link_to_image': row[58], //BG
              'newspaper_details_slogan': row[59], //BH
              'allocated_for_future': row[60], //BI
              'link_to_page': row[61], //BJ
              'remaining_Male_quota': row[62], //BK
              'remaining_Female_quota': row[63], //BL
              'country_flag': countryFlags[row[4]]
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
              .update({'frequency': value['frequency'] + 1}).then(
                  (value) async {
            await FirebaseFirestore.instance
                .collection('country')
                .doc(data[i]['country']
                    .toLowerCase()
                    .replaceAll(' ', '_')
                    .trim())
                .collection('jobs')
                .doc(data[i]['job_identifier'].toString())
                .set(data[i]);
            print('update');
          });
        } else {
          FirebaseFirestore.instance
              .collection('country')
              .doc(data[i]['country'].toLowerCase().replaceAll(' ', '_').trim())
              .set({
            'country_name': data[i]['country'],
            'frequency': 1,
            'country_flag': data[i]['country_flag']
          }).then((value) async {
            await FirebaseFirestore.instance
                .collection('country')
                .doc(data[i]['country']
                    .toLowerCase()
                    .replaceAll(' ', '_')
                    .trim())
                .collection('jobs')
                .doc(data[i]['job_identifier'].toString())
                .set(data[i]);
            print('add');
          });
        }
      });

      // addcountry(data[i]['country']).then((value) {
      // });
      uploadedRows++;
      final newProgress = uploadedRows / totalRows;
      jobController.progress.value = newProgress;

      addJobType(data[i]['job_title']);
    }
    Get.snackbar('File Uploaded', 'File Uploaded successfully');
    jobController.isLoading.value = false;
    jobController.filePath.value = '';
  }
//Construction Carpenter

  void addJobType(String jobTypeId) async {
    log('path is ${jobTypeId.toLowerCase().replaceAll(' ', '_').trim()}');
    await FirebaseFirestore.instance
        .collection('job_type')
        .doc(jobTypeId.toLowerCase().replaceAll(' ', '_').trim())
        .get()
        .then((value) async {
      if (value.exists) {
        await FirebaseFirestore.instance
            .collection('job_type')
            .doc(jobTypeId.toLowerCase().replaceAll(' ', '_').trim())
            .update({'frequency': value['frequency'] + 1}).then((value) {
          print('update');
        });
      } else {
        await FirebaseFirestore.instance
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
              'website': row[14],
              'messenger': row[15],
              'whatsapp': row[16]
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

  String? _countryFileName;
  List<List<dynamic>>? countryRows;

  void pickCountryFile() async {
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
        _countryFileName = result.files.single.name;
        countryRows = sheet!.rows;
        jobController.countryFilePath.value = result.files.single.path!;
      });
      //  await _uploadToFirestore();
    } else {
      // User canceled the picker
    }
  }

  Future<void> _uploadCountryDataToFirestore() async {
    jobController.iscountryLoading.value = true;
    jobController.countryProgress.value = 0.0;

    if (countryRows == null) return;
    final data = countryRows!
        .skip(1)
        .map((row) => {
              'name': row[1],
              'nepali_name': row[2],
              'capital': row[3],
              'nepali_capital': row[4],
              'about': row[5],
              'about_nepal': row[5],
              'currency': row[5],
            })
        .toList();

    final totalRows = data.length;
    var uploadedRows = 0;

    // log('data is $data');
    for (int i = 0; i < data.length; i++) {
      print(data[i]);

      await FirebaseFirestore.instance
          .collection('country_info')
          .doc(data[i]['name']
              .toString()
              .toLowerCase()
              .replaceAll(' ', '_')
              .trim())
          .set(data[i]);
      uploadedRows++;
      final newProgress = uploadedRows / totalRows;
      jobController.countryProgress.value = newProgress;
    }
    Get.snackbar('File Uploaded', 'File Uploaded successfully');
    jobController.iscountryLoading.value = false;
    jobController.countryFilePath.value = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new_outlined)),
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

              // for country
              SizedBox(
                height: Adaptive.h(5),
              ),

              if (jobController.iscountryLoading.value)
                Column(
                  children: [
                    const CircularProgressIndicator(
                      color: primaryColor,
                    ),
                    const SizedBox(height: 16),
                    Text(
                        '${(jobController.countryProgress.value * 100).toStringAsFixed(1)}%'),
                    LinearProgressIndicator(
                        color: primaryColor,
                        backgroundColor: lightGrey,
                        value: jobController.countryProgress.value),
                  ],
                )
              else if (jobController.countryFilePath.value.isNotEmpty)
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      return primaryColor;
                    }),
                  ),
                  onPressed: _uploadCountryDataToFirestore,
                  child: const Text('Upload Country Data to Firestore'),
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
                    onPressed: pickCountryFile,
                    child: const Text('Pick Country File'),
                  ),
                ),
            ],
          ),
        ),
      )),
    );
  }
}

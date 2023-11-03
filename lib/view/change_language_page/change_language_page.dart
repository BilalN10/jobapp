import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/constants.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/main.dart';
import 'package:job_app/view/widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  SharedPreferences? prefs;
  AuthcController authcController = Get.put(AuthcController());
  @override
  void initState() {
    initialize();

    super.initState();
  }

  initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('change_language'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryButton(
                  onPressed: () async {
                    Get.updateLocale(const Locale('en', 'US'));
                    await prefs!.setString('language_code', 'en');
                    await prefs!.setString('country_code', 'US');
                    authcController.fetchLanguage();
                  },
                  text: 'English'),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryButton(
                  onPressed: () async {
                    Get.updateLocale(const Locale('ne', 'NP'));
                    await prefs!.setString('language_code', 'ne');
                    await prefs!.setString('country_code', 'NP');
                    authcController.fetchLanguage();
                  },
                  text: 'Nepali'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/view/authentication_pages/login_page.dart';
import 'package:job_app/view/bottom_navbar/bottom_navbar_page.dart';
import 'package:job_app/view/select_language/select_langauge.dart';

class InitialRoot extends StatelessWidget {
  const InitialRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AuthcController>(
      initState: (_) {
        Get.put<AuthcController>(AuthcController());
      },
      builder: (_) {
        if (Get.find<AuthcController>().firebaseUser.value != null) {
          print('if call');
          return const BottomNavBarPage();
        } else {
          print('else call');
          return const SelectLanguagePage();
        }
      },
    );
  }
}

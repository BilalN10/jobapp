import 'dart:developer';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/bindings/auth_bindings.dart';
import 'package:job_app/controller/auth_controller.dart';
import 'package:job_app/languages/languages.dart';
import 'package:job_app/view/share_job_detail/share_job_detail.dart';
import 'package:job_app/view/splash_page/splash_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initDynamicLinks();

    super.initState();
  }

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.queryParameters;
      if (queryParams.isNotEmpty) {
        log('query param is $queryParams');
        Get.to(() => ShareJobDetail(JobId: queryParams['id']!));
      }
    }).onError((error) {
      print('error is ${error.toString()}');
    });
  }

  final AuthcController auth = Get.put(AuthcController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Obx(
        () => GetMaterialApp(
          initialBinding: AuthBinding(),
          debugShowCheckedModeBanner: false,
          locale: Locale(auth.languageCode.value, auth.countryCode.value),
          fallbackLocale:
              Locale(auth.languageCode.value, auth.countryCode.value),
         
          translations: Languages(),
          title: 'Baideshik Rojgar',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashPage(),
        ),
      );
    });
  }
}

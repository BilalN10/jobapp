import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/bottom_navbar/bottom_navbar_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // runApp(
  //   DevicePreview(
  //     //enabled: !kReleaseMode,
  //     builder: (context) => const MyApp(), // Wrap your app
  //   ),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BottomNavBarPage(),
      );
    });
  }
}

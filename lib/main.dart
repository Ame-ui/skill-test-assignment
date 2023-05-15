import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_test_assignment/controller/controller_otp.dart';
import 'package:skill_test_assignment/value/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OtpController());
    return GetMaterialApp(
      initialRoute: Routes.home,
      getPages: Routes.getPages,
      debugShowCheckedModeBanner: false,
    );
  }
}

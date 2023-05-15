import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:skill_test_assignment/model/opt_response.dart';
import 'package:skill_test_assignment/network/network.dart';

class OtpController extends GetxController {
  OtpResponse? otpResponse;
  String otpCode = '';
  bool isLoading = false;
  bool isCustomKeyboardOpen = true;
  bool isError = false;
  bool isValid = false;
  material.TextEditingController optPinController =
      material.TextEditingController();
  material.GlobalKey<material.FormState> formKey =
      material.GlobalKey<material.FormState>();

  getOtpCode() async {
    //for loading dialog
    isLoading = true;
    update();
    await Network().fetchOtpCode().then((value) {
      int? statusCode = 0;
      if (value is DioError) {
        statusCode = value.response!.statusCode;
      } else {
        statusCode = value.statusCode;
      }
      print('opt statusCode: $statusCode');
      if (statusCode == 200) {
        var data = utf8.decode(value.data);
        otpResponse = optResponseFromJson(data);

        // decrypt code
        final specialKey = Key.fromUtf8(otpResponse!.meta.secretKey);
        final initVector = IV.fromLength(16);
        final encryptor = Encrypter(AES(specialKey, mode: AESMode.ecb));
        otpCode = encryptor.decrypt64(otpResponse!.code, iv: initVector);

        // show snackbar
        Get.showSnackbar(GetSnackBar(
          title: 'OTP',
          message: otpCode,
          backgroundColor: material.Colors.black,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        ));
      }
    });
    isLoading = false;
    update();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skill_test_assignment/controller/controller_otp.dart';
import 'package:skill_test_assignment/widget/otp_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(builder: (controller) {
      return Scaffold(
        body: controller.isLoading
            ? AlertDialog(
                title: Text(
                  'Message',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                content: const Text('Please Wait'),
              )
            : Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.blueGrey.shade900)),
                    onPressed: () async {
                      await controller.getOtpCode();
                      controller.isCustomKeyboardOpen = true;
                      controller.update();
                      showModalBottomSheet(
                        context: context,
                        builder: ((context) => const OtpBottomSheer()),
                      );
                    },
                    child: const Text('OTP တောင်းမည်')),
              ),
      );
    });
  }
}

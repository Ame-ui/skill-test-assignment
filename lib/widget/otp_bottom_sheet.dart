import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pinput/pinput.dart';
import 'package:skill_test_assignment/controller/controller_otp.dart';

class OtpBottomSheer extends StatelessWidget {
  const OtpBottomSheer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          if (controller.isCustomKeyboardOpen == true) {
            //hide custom keyboard
            controller.isCustomKeyboardOpen = false;
            controller.update();
            return false;
          } else {
            //reset all value
            controller.optPinController.clear();
            controller.isValid = false;
            controller.isError = false;
            return true;
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /* Title */
                  Text(
                    'OTP ကုဒ်နံပါတ်အားဖြည့်ပါ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  /* Subtitle */
                  Text('တစ်ခါသုံးကုဒ်ဖြစ်သောကြောင့် ၁မိနစ်အတွင်းထည့်ပါ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          )),
                  const SizedBox(height: 10),
                  /* Pin textfield */
                  Center(
                    //use inkwell bacuz if (useNativeKeyboard: false), pinput is disabled
                    child: InkWell(
                      onTap: (() {
                        //to open custom keyboard if pinput is tapped
                        controller.isCustomKeyboardOpen = true;
                        controller.update();
                      }),
                      child: Pinput(
                        controller: controller.optPinController,
                        length: 6,
                        defaultPinTheme: PinTheme(
                            width: 57,
                            height: 60,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: controller
                                                .optPinController.text.length <
                                            6
                                        ? Colors.black
                                        : controller.isError
                                            ? Colors.red
                                            : controller.isValid
                                                ? Colors.green
                                                : Colors.black),
                                borderRadius: BorderRadius.circular(10))),
                        useNativeKeyboard: false,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  /* Submit button */
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                const MaterialStatePropertyAll(Colors.white),
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.blueGrey.shade900)),
                        onPressed: () {
                          //do some comfirmation
                        },
                        child: const Text('အတည်ပြုမည်')),
                  ),
                ],
              ),
            ),
            /* Custom keyboard */
            Visibility(
              visible: controller.isCustomKeyboardOpen,
              child: Expanded(
                child: Container(
                  color: Colors.grey.shade300,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      GridView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: 12,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 4.5 / 2,
                            crossAxisCount: 3,
                          ),
                          itemBuilder: ((context, index) {
                            /* Backspace */
                            if (index == 11) {
                              return InkWell(
                                onTap: () {
                                  if (controller
                                      .optPinController.text.isNotEmpty) {
                                    controller.optPinController.text =
                                        controller.optPinController.text
                                            .substring(
                                                0,
                                                controller.optPinController.text
                                                        .length -
                                                    1);
                                    controller.update();
                                  }
                                },
                                child: const Center(
                                    child: Icon(
                                  Icons.backspace,
                                  color: Colors.black,
                                )),
                              );
                            }
                            /* Number Zero */
                            if (index == 10) {
                              return InkWell(
                                onTap: () {
                                  if (controller.optPinController.text.length <
                                      6) {
                                    controller.optPinController.text += '0';
                                  }
                                  if (controller.optPinController.text.length ==
                                      6) {
                                    controller.isCustomKeyboardOpen = false;
                                    //check otp code
                                    if (controller.otpCode ==
                                        controller.optPinController.text) {
                                      controller.isError = false;
                                      controller.isValid = true;
                                    } else {
                                      controller.isValid = false;
                                      controller.isError = true;
                                    }
                                  }
                                  controller.update();
                                },
                                child: Container(
                                    margin: const EdgeInsets.all(5),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      '0',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(fontSize: 26),
                                    ))),
                              );
                            }
                            /* empty */
                            if (index == 9) {
                              return const SizedBox.shrink();
                            }
                            /* Normal Number (1-9)*/
                            return InkWell(
                              onTap: () {
                                if (controller.optPinController.text.length <
                                    6) {
                                  controller.optPinController.text +=
                                      (index + 1).toString();
                                }
                                if (controller.optPinController.text.length ==
                                    6) {
                                  controller.isCustomKeyboardOpen = false;
                                  //check otp code
                                  if (controller.otpCode ==
                                      controller.optPinController.text) {
                                    controller.isError = false;
                                    controller.isValid = true;
                                  } else {
                                    controller.isValid = false;
                                    controller.isError = true;
                                  }
                                }
                                controller.update();
                              },
                              child: Container(
                                  margin: const EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    (index + 1).toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontSize: 26),
                                  ))),
                            );
                          })),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

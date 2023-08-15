import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/screens/auth/otp_verification_screen.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class EmailVerificationController extends GetxController {
  final RxBool emailVerificationInProgress = false.obs;
  final TextEditingController emailTEController = TextEditingController();

  Future<void> sendOTPToEmail() async {
    emailVerificationInProgress.value = true;

    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.sendOtpToEmail(emailTEController.text.trim()));

    emailVerificationInProgress.value = false;

    if (response.isSuccess) {
      Get.to(() => OtpVerificationScreen(email: emailTEController.text.trim()));
    } else {
      Get.snackbar(
          'Email Verification Failed', 'Email verification has failed!');
    }
  }
}

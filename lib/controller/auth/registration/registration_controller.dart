import 'dart:io';

import 'package:qrpay/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/model/auth/registation/check_register_user_model.dart';
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/services/api_services.dart';

class RegistrationController extends GetxController {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  RxString countryCode = "".obs;

  @override
  void onInit() {
    countryCode.value = LocalStorages.getCountryCode()!;
    super.onInit();
  }

  RxString verify = ''.obs;
  RxInt resendAuthToken = 0.obs;

  void onTapContinue() {
    Get.toNamed(Routes.emailOtpScreen);
  }

  void onPressedSignIn() {
    Get.toNamed(Routes.signInScreen);
  }

  File? fronImage;
  File? backImage;

  //end kyc form

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late CheckRegisterUserModel _checkRegisterUserModel;

  CheckRegisterUserModel get checkRegisterUserModel => _checkRegisterUserModel;

  // check Exist User Process process function
  Future<CheckRegisterUserModel> checkExistUserProcess() async {
    _isLoading.value = true;
    update();

    debugPrint(countryCode.value.toString());
    Map<String, dynamic> inputBody = {
      'email': emailController.text,
    };
    // check Exist User api from api service
    await ApiServices.checkRegisterApi(body: inputBody).then((value) {
      _checkRegisterUserModel = value!;
      if (LocalStorages.isEmailVerification()) {
        Get.toNamed(Routes.emailOtpScreen);
        sendOTPEmailProcess(email: emailController.text);
      } else {
        Get.toNamed(Routes.kycFromScreen);
      }

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _checkRegisterUserModel;
  }

//!  reesend otp
  final isVerifyCode = false.obs;

  final _isSendOTPLoading = false.obs;

  bool get isSendOTPLoading => _isSendOTPLoading.value;

  //! Send OTP Email Process
  late CommonSuccessModel _sendOTPEmailModel;

  CommonSuccessModel get sendOTPEmailModel => _sendOTPEmailModel;

  Future<CommonSuccessModel> sendOTPEmailProcess(
      {required String email}) async {
    _isSendOTPLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'email': email,
      'agree': '1',
    };

    await ApiServices.sendRegisterOTPEmailApi(body: inputBody).then((value) {
      _sendOTPEmailModel = value!;

      _isSendOTPLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isSendOTPLoading.value = false;
    update();
    return _sendOTPEmailModel;
  }

  final _isLoading2 = false.obs;

  bool get isLoading2 => _isLoading2.value;

  late CommonSuccessModel _verifyEmailModel;

  CommonSuccessModel get verifyEmailModel => _verifyEmailModel;

  // Verify email process function
  Future<CommonSuccessModel> verifyEmailProcess(
      {required String otpCode}) async {
    _isLoading2.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'email': emailController.text,
      'code': otpCode,
    };

    await ApiServices.verifyRegisterEmailApi(body: inputBody).then((value) {
      _verifyEmailModel = value!;
      _isLoading2.value = false;

      update();
      Get.toNamed(Routes.kycFromScreen);
    }).catchError((onError) {
      _isLoading2.value = false;
      log.e(onError);
    });

    _isLoading2.value = false;
    update();
    return _verifyEmailModel;
  }
}

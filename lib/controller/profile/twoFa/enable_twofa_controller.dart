import 'package:qrpay/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/model/two_fa/two_fa_info_model.dart';
import '../../../backend/services/api_services.dart';

class TwoFaController extends GetxController {
  final numberController = TextEditingController();

  @override
  void onInit() {
    getBasicData();
    super.onInit();
  }

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late TwoFaInfoModel _twoFaInfoModelData;

  TwoFaInfoModel get twoFaInfoModelData => _twoFaInfoModelData;

  Future<TwoFaInfoModel> getBasicData() async {
    _isLoading.value = true;
    update();

    // calling  from api service
    await ApiServices.getTwoFAInfoAPi().then((value) {
      _twoFaInfoModelData = value!;

      _isLoading.value = false;
      update();
    }).catchError(
      (onError) {
        log.e(onError);
      },
    );
    update();
    return _twoFaInfoModelData;
  }

  void gotoOtp() {
    Get.toNamed(Routes.otp2FaScreen);
  }
}

import 'dart:async';

import 'package:get/get.dart';

import '../../backend/model/app_settings/app_settings_model.dart';
import '../../backend/services/api_endpoint.dart';
import '../../backend/services/api_services.dart';
import '../../utils/strings.dart';

class AppSettingsController extends GetxController {
  final List<OnboardScreen> onboardScreen = [];

  RxString splashImagePath = ''.obs;
  RxString appBasicLogoWhite = ''.obs;
  RxString appBasicLogoDark = ''.obs;
  RxString privacyPolicy = ''.obs;
  RxString contactUs = ''.obs;
  RxString aboutUs = ''.obs;
  RxString path = ''.obs;
  RxBool isVisible = false.obs;
  @override
  void onInit() {
    getSplashAndOnboardData().then((value) {
      Timer(const Duration(seconds: 4), () {
        isVisible.value = true;
      });
    });
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late AppSettingsModel _appSettingsModel;
  AppSettingsModel get appSettingsModel => _appSettingsModel;

  Future<AppSettingsModel> getSplashAndOnboardData() async {
    _isLoading.value = true;
    update();

    await ApiServices.appSettingsApi().then((value) {
      _appSettingsModel = value!;
      splashImagePath.value =
          "${ApiEndpoint.mainDomain}/${_appSettingsModel.data.screenImagePath}/${_appSettingsModel.data.appSettings.merchant.splashScreen.splashScreenImage}";

      for (var element
          in _appSettingsModel.data.appSettings.merchant.onboardScreen) {
        onboardScreen.add(
          OnboardScreen(
            id: element.id,
            title: element.title,
            subTitle: element.subTitle,
            image: element.image,
            status: element.status,
            createdAt: element.createdAt,
            updatedAt: element.updatedAt,
          ),
        );
      }

      path.value =
          "${ApiEndpoint.mainDomain}/${_appSettingsModel.data.logoImagePath}/";

      if (_appSettingsModel.data.appSettings.merchant.basicSettings.siteLogo ==
          '') {
        appBasicLogoWhite.value =
            "${ApiEndpoint.mainDomain}/${_appSettingsModel.data.defaultImage}";
        appBasicLogoDark.value = appBasicLogoWhite.value;
      } else {
        appBasicLogoWhite.value =
            "${ApiEndpoint.mainDomain}/${_appSettingsModel.data.logoImagePath}/${_appSettingsModel.data.appSettings.merchant.basicSettings.siteLogo}";
        appBasicLogoDark.value =
            "${ApiEndpoint.mainDomain}/${_appSettingsModel.data.logoImagePath}/${_appSettingsModel.data.appSettings.merchant.basicSettings.siteLogoDark}";
      }

      Strings.appName =
          _appSettingsModel.data.appSettings.merchant.basicSettings.siteName;
      update();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });
    _isLoading.value = false;
    update();
    return _appSettingsModel;
  }
}

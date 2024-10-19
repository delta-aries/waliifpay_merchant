import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrpay/backend/local_storage/local_storage.dart';
import '../../backend/model/bottom_navbar_model/dashboard_model.dart';
import '../../backend/model/pusher/pusher_beams_model.dart';
import '../../backend/services/api_endpoint.dart';
import '../../backend/services/api_services.dart';
import '../../backend/services/pusher/pusher_api_services.dart';
import 'package:pusher_beams/pusher_beams.dart';

class DashBoardController extends GetxController {
  RxBool receiveMoney = false.obs;
  RxBool withdrawMoney = false.obs;
  RxBool developerApiKey = false.obs;
  RxBool gatewaySetting = false.obs;
  RxBool payLink = false.obs;
  @override
  void onInit() {
    getDashboardData();
    super.onInit();
  }

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  late DashboardModel _dashboardModel;

  DashboardModel get dashBoardModel => _dashboardModel;

  Future<DashboardModel> getDashboardData() async {
    _isLoading.value = true;
    update();

    // calling  from api service
    await ApiServices.dashboardApi().then((value) async {
      _dashboardModel = value!;
      var moduleAccess = _dashboardModel.data.moduleAccess;
      receiveMoney.value = moduleAccess.receiveMoney;
      withdrawMoney.value = moduleAccess.withdrawMoney;
      developerApiKey.value = moduleAccess.developerApiKey;
      gatewaySetting.value = moduleAccess.gatewaySetting;
      payLink.value = moduleAccess.payLink;

      getPusherAuth();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    update();
    return _dashboardModel;
  }

  // Register Pusher Beams
  final _isPusherBeamsLoading = false.obs;
  bool get isPusherBeamsLoading => _isPusherBeamsLoading.value;
  late PusherBeamsModel _pusherBeamsModel;

  PusherBeamsModel get pusherBeamsModel => _pusherBeamsModel;

  Future<PusherBeamsModel> getPusherAuth() async {
    _isPusherBeamsLoading.value = true;

    update();
    await PusherApiServices.getPusherBeamsAuth(LocalStorages.getId() ?? '')
        .then((value) {
      _pusherBeamsModel = value!;
      getSecure();
      _isPusherBeamsLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    update();
    return _pusherBeamsModel;
  }

  getSecure() async {
    final BeamsAuthProvider provider = BeamsAuthProvider()
      ..authUrl = ApiEndpoint.pusherBeamsAuthMain
      ..headers = {'Content-Type': 'application/json'}
      ..queryParams = {'user_id': LocalStorages.getId() ?? ''}
      ..credentials = 'omit';

    await PusherBeams.instance.setUserId(
      LocalStorages.getId() ?? '',
      provider,
      (error) => {
        if (error != null) {debugPrint("----------$error---------")}
      },
    );
  }
}

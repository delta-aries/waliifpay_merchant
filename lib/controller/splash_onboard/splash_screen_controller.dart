import 'package:get/get.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../routes/routes.dart';
import 'navigator_plug.dart';

class SplashController extends GetxController {
  final navigatorPlug = NavigatorPlug();

  @override
  void onReady() {
    super.onReady();
    navigatorPlug.startListening(
      seconds: 3,
      onChanged: () {
        LocalStorages.isLoggedIn()
            ? Get.offAndToNamed(Routes.signInScreen)
            : Get.offAndToNamed(
                LocalStorages.isOnBoardDone()
                    ? Routes.signInScreen
                    : Routes.onboardScreen,
              );
      },
    );
  }

  @override
  void onClose() {
    navigatorPlug.stopListening();
    super.onClose();
  }
}

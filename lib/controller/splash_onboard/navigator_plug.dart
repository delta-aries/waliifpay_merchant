import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../language/language_controller.dart';

class NavigatorPlug {
  StreamSubscription<bool>? _subscription;
  bool _timerStarted = false;

  void startListening({
    required int seconds,
    required VoidCallback onChanged,
  }) {
    _subscription = Get.find<LanguageController>().isLoadingValue.stream.listen(
      (isLoading) {
        if (!_timerStarted) {
          _timerStarted = true;
          Timer(
            Duration(seconds: seconds),
            () {
              if (!Get.find<LanguageController>().isLoadingValue.value) {
                _subscription?.cancel();
                onChanged();
              } else {
                _timerStarted = false;
              }
            },
          );
        }
      },
    );
  }

  void stopListening() {
    _subscription?.cancel();
  }
}

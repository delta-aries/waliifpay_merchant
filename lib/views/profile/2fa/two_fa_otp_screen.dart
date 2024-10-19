// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrpay/utils/custom_color.dart';
import 'package:qrpay/widgets/text_labels/title_heading2_widget.dart';

import '../../../controller/profile/twoFa/two_fa_otp_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/responsive_layout.dart';
import '../../../utils/size.dart';
import '../../../utils/strings.dart';
import '../../../widgets/appbar/back_button.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/inputs/otp_input_widget.dart';
import '../../../widgets/others/congratulation_widget.dart';
import '../../../widgets/text_labels/title_heading4_widget.dart';

class Otp2FaScreen extends StatelessWidget {
  Otp2FaScreen({Key? key}) : super(key: key);
  final controller = Get.put(TwoFaOtpController());
  final otpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(Routes.bottomNavBarScreen);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
            leading: BackButtonWidget(
              onTap: () {
                Get.offAllNamed(Routes.bottomNavBarScreen);
              },
            ),
          ),
          body: _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(Dimensions.paddingSize),
      physics: const BouncingScrollPhysics(),
      children: [
        _titleAndSubtitleWidget(context),
        _inputWidget(context),
        _continueButtonWidget(context),
      ],
    );
  }

  _titleAndSubtitleWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 3,
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          TitleHeading2Widget(text: Strings.enable2FASecurity.tr),
          verticalSpace(Dimensions.heightSize * 0.7),
          TitleHeading4Widget(text: Strings.enterTheGoogleAuthOTPCode.tr)
        ],
      ),
    );
  }

  _inputWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: Dimensions.heightSize * 5,
          ),
          child: OtpInputTextFieldWidget(
            controller: controller.emailOtpInputController,
          ),
        ),
      ],
    );
  }

  _continueButtonWidget(BuildContext context) {
    return PrimaryButton(
      title: Strings.submit.tr,
      onPressed: () {
        controller.twoFAEnabledProcess().then((value) => StatusScreen.show(
            context: context,
            subTitle: Strings.yourTwoSecurityHAsBeenActive.tr,
            onPressed: () {
              Get.offAllNamed(Routes.bottomNavBarScreen);
            }));
      },
    );
  }
}

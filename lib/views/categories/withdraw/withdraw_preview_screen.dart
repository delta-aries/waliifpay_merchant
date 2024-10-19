import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrpay/utils/responsive_layout.dart';
import 'package:qrpay/utils/strings.dart';
import 'package:qrpay/widgets/appbar/appbar_widget.dart';
import 'package:qrpay/widgets/others/preview/amount_preview_widget.dart';
import 'package:qrpay/widgets/others/preview/information_amount_widget.dart';

import '../../../controller/categories/withdraw_controller/withdraw_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/buttons/primary_button.dart';

class WithdrawPreviewScreen extends StatelessWidget {
  WithdrawPreviewScreen({super.key});

  final controller = Get.put(WithdrawController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileScaffold: Scaffold(
      appBar: AppBarWidget(text: Strings.preview.tr),
      body: _bodyWidget(context),
    ));
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.8),
      physics: const BouncingScrollPhysics(),
      children: [
        _amountWidget(context),
        _amountInformationWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _amountWidget(BuildContext context) {
    return previewAmount(amount: controller.enteredAmount);
  }

  _amountInformationWidget(BuildContext context) {
    return amountInformationWidget(
      information: Strings.amountInformation.tr,
      enterAmount: Strings.enterAmount.tr,
      enterAmountRow: controller.enteredAmount,
      fee: Strings.transferFee.tr,
      feeRow: controller.transferFeeAmount,
      received: Strings.recipientReceived.tr,
      receivedRow: controller.youWillGet,
      total: Strings.totalPayable.tr,
      totalRow: controller.enteredAmount,
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * 2,
      ),
      child: PrimaryButton(
          title: Strings.confirm.tr,
          onPressed: () {
            if (controller.selectedCurrencyType.value.contains("AUTOMATIC")) {
              if (controller.selectedCurrencyAlias.value == "flutterwave-ngn-money-out-automatic" ||
                  controller.selectedCurrencyAlias.value ==
                      "flutterwave-usd-money-out-automatic" ||
                  controller.selectedCurrencyAlias.value ==
                      "flutterwave-tzs-money-out-automatic") {
                Get.toNamed(Routes.withdrawFlutterwaveScreen);
              }
            } else {
              Get.toNamed(Routes.withdrawManualPaymentScreen);
            }
          }),
    );
  }
}

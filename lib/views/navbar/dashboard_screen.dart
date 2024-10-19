import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qrpay/backend/utils/custom_loading_api.dart';
import 'package:qrpay/controller/navbar/dashboard_controller.dart';
import 'package:qrpay/routes/routes.dart';
import 'package:qrpay/utils/custom_color.dart';
import 'package:qrpay/utils/custom_style.dart';
import 'package:qrpay/utils/dimensions.dart';
import 'package:qrpay/utils/responsive_layout.dart';
import 'package:qrpay/utils/size.dart';
import 'package:qrpay/utils/strings.dart';
import 'package:qrpay/widgets/buttons/primary_button.dart';
import 'package:qrpay/widgets/text_labels/custom_title_heading_widget.dart';
import '../../backend/utils/no_data_widget.dart';
import '../../widgets/bottom_navbar/transaction_history_widget.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final controller = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        body: Obx(
          () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: Colors.black,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      strokeWidth: 2.5,
      onRefresh: () async {
        controller.getDashboardData();
        return Future<void>.delayed(const Duration(seconds: 3));
      },
      child: Stack(
        children: [
          ListView(
            children: [
              _appBarContainer(context),
              _topButtonWidget(context),
            ],
          ),
          _draggableSheet(context)
        ],
      ),
    );
  }

  _draggableSheet(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (_, scrollController) {
        return _transactionWidget(context, scrollController);
      },
      initialChildSize: 0.60,
      minChildSize: 0.60,
      maxChildSize: 0.72,
    );
  }

  _buildColumn(String text, String headingTextKey) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTitleHeadingWidget(
            text: text,
            style: CustomStyle.darkHeading1TextStyle.copyWith(
              fontSize: Dimensions.headingTextSize3,
              fontWeight: FontWeight.w800,
              color: CustomColor.whiteColor.withOpacity(0.8),
            ),
            maxLines: 1,
          ),
          CustomTitleHeadingWidget(
            text: headingTextKey.tr,
            style: CustomStyle.lightHeading4TextStyle.copyWith(
              fontSize: Dimensions.headingTextSize3 * 0.9,
              color: CustomColor.whiteColor.withOpacity(0.6),
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  _appBarContainer(BuildContext context) {
    final double paddingSize = Dimensions.paddingSize;
    final data = controller.dashBoardModel.data;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(paddingSize * 0.5),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(Dimensions.radius * 1.7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          verticalSpace(Dimensions.heightSize * 0.6),
          CustomTitleHeadingWidget(
            text: '${data.userWallet.balance} ${data.userWallet.currency}',
            style: CustomStyle.darkHeading1TextStyle.copyWith(
              fontSize: Dimensions.headingTextSize4 * 2,
              fontWeight: FontWeight.w800,
              color: CustomColor.whiteColor,
            ),
          ),
          CustomTitleHeadingWidget(
            text: Strings.walletBalance.tr,
            style: CustomStyle.lightHeading4TextStyle.copyWith(
              fontSize: Dimensions.headingTextSize3,
              color: CustomColor.whiteColor.withOpacity(0.6),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: paddingSize * 0.7,
              right: paddingSize * 0.7,
              top: paddingSize * 1.2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildColumn(data.gatewayAmount, Strings.gatewayBalance.tr),
                _buildColumn(data.receiveMoney, Strings.receivedBalance.tr),
              ],
            ),
          ),
          verticalSpace(Dimensions.heightSize * 0.6),
        ],
      ),
    );
  }

  _topButtonWidget(BuildContext context) {
    return Padding(
      padding: controller.withdrawMoney.value && controller.receiveMoney.value
          ? EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.5)
          : EdgeInsets.zero,
      child: Row(
        children: [
          if (controller.withdrawMoney.value) ...[
            Expanded(
              child: PrimaryButton(
                title: Strings.withdraw.tr,
                onPressed: () {
                  Get.toNamed(Routes.withdrawScreen);
                },
                borderColor: Theme.of(context).primaryColor,
                borderWidth: 2,
                buttonColor: Get.isDarkMode
                    ? CustomColor.transparent
                    : CustomColor.whiteColor,
                buttonTextColor: Theme.of(context).primaryColor,
                radius: Dimensions.radius * 2.5,
              ),
            ),
          ],
          horizontalSpace(10),
          if (controller.receiveMoney.value) ...[
            Expanded(
              child: PrimaryButton(
                title: Strings.receiveMoney.tr,
                onPressed: () {
                  Get.toNamed(Routes.moneyReceiveScreen);
                },
                borderWidth: 2,
                buttonColor: Theme.of(context).primaryColor,
                radius: Dimensions.radius * 2.5,
              ),
            ),
          ]
        ],
      ),
    );
  }

  _transactionWidget(BuildContext context, ScrollController scrollController) {
    var data = controller.dashBoardModel.data.transactions;
    return data.isEmpty
        ? NoDataWidget(
            title: Strings.noTransaction.tr,
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius * 2.5),
                topRight: Radius.circular(Dimensions.radius * 2.5),
              ),
              color: Get.isDarkMode
                  ? CustomColor.primaryBGDarkColor
                  : CustomColor.whiteColor,
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSize * 0.8,
              ),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CustomTitleHeadingWidget(
                  text: Strings.recentTransactions.tr,
                  padding: EdgeInsets.only(top: Dimensions.paddingSize),
                  style: Get.isDarkMode
                      ? CustomStyle.darkHeading3TextStyle.copyWith(
                          fontSize: Dimensions.headingTextSize2,
                          fontWeight: FontWeight.w600,
                        )
                      : CustomStyle.lightHeading3TextStyle.copyWith(
                          fontSize: Dimensions.headingTextSize2,
                          fontWeight: FontWeight.w600,
                        ),
                ),
                verticalSpace(Dimensions.widthSize),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return TransactionWidget(
                          amount: data[index].requestAmount,
                          title: data[index].transactionType,
                          dateText: DateFormat.d().format(data[index].dateTime),
                          transaction: data[index].trx,
                          monthText:
                              DateFormat.MMMM().format(data[index].dateTime),
                          status: data[index].status,
                        );
                      }),
                )
              ],
            ),
          );
  }
}

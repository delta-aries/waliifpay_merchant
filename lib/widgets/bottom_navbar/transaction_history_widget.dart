import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrpay/utils/custom_color.dart';
import 'package:qrpay/utils/custom_style.dart';
import 'package:qrpay/widgets/text_labels/custom_title_heading_widget.dart';
import 'package:qrpay/widgets/text_labels/title_heading3_widget.dart';
import 'package:qrpay/widgets/text_labels/title_heading4_widget.dart';

import '../../language/language_controller.dart';
import '../../utils/dimensions.dart';
import '../../utils/size.dart';
import '../text_labels/title_heading5_widget.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget(
      {super.key,
      required this.amount,
      required this.title,
      required this.dateText,
      this.status,
      required this.transaction,
      required this.monthText});

  final String title, monthText, dateText, amount, transaction;
  final String? status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.paddingSize * 0.3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          color: Theme.of(context).primaryColor.withOpacity(0.05),
        ),
        padding: EdgeInsets.only(right: Dimensions.paddingSize * 0.2),
        child: Row(
          children: [
            Expanded(
                flex: 4,
                child: Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.marginSizeVertical * 0.4,
                    top: Dimensions.marginSizeVertical * 0.5,
                    bottom: Dimensions.marginSizeVertical * 0.4,
                    right: Dimensions.marginSizeVertical * 0.2,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.04),
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * 0.6),
                  ),
                  child: Column(
                    mainAxisAlignment: mainCenter,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: crossCenter,
                    children: [
                      TitleHeading4Widget(
                        text: dateText,
                        fontSize: Dimensions.headingTextSize3 * 2,
                        fontWeight: FontWeight.w800,
                        color: Get.isDarkMode
                            ? CustomColor.primaryDarkTextColor
                            : CustomColor.primaryDarkColor,
                      ),
                      TitleHeading4Widget(
                        text: monthText,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Get.isDarkMode
                            ? CustomColor.primaryDarkTextColor
                            : CustomColor.primaryDarkColor,
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: crossStart,
                mainAxisAlignment: mainCenter,
                children: [
                  TitleHeading3Widget(
                    text: Get.find<LanguageController>().getTranslation(
                      snakeCaseToCamelCase(title),
                    ),
                    fontSize: Dimensions.headingTextSize4,
                    color: Get.isDarkMode
                        ? CustomColor.primaryDarkTextColor
                        : CustomColor.primaryDarkColor,
                  ),
                  verticalSpace(Dimensions.widthSize * 0.7),
                  CustomTitleHeadingWidget(
                    text: transaction,
                    style: CustomStyle.darkHeading4TextStyle.copyWith(
                      fontSize: Dimensions.headingTextSize5,
                      fontWeight: FontWeight.w400,
                      color: Get.isDarkMode
                          ? CustomColor.primaryDarkTextColor
                          : CustomColor.primaryDarkColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: status != null,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSize * .2,
                        vertical: Dimensions.paddingSize * .1,
                      ),
                      decoration: BoxDecoration(
                        color: status == 'Pending'
                            ? CustomColor.pendingColor
                            : status == 'success'
                                ? CustomColor.successColor
                                : CustomColor.redColor.withOpacity(1),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius * 0.5),
                      ),
                      child: TitleHeading5Widget(
                        text: Get.find<LanguageController>()
                            .getTranslation(status!.toLowerCase()),
                        fontSize: Dimensions.headingTextSize5 * 0.8,
                        color: CustomColor.primaryDarkTextColor,
                      ),
                    ),
                  ),
                  TitleHeading3Widget(
                    text: amount,
                    fontSize: Dimensions.headingTextSize5,
                    color: Get.isDarkMode
                        ? CustomColor.primaryDarkTextColor
                        : CustomColor.primaryDarkColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String snakeCaseToCamelCase(String input) {
    List<String> parts = input.split('-');
    String camelCase = parts.first.toLowerCase() +
        parts
            .sublist(1)
            .map((part) =>
                part[0].toUpperCase() + part.substring(1).toLowerCase())
            .join();
    return camelCase;
  }
}

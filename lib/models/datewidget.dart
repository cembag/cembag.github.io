import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weloggerweb/globalvalues/globalvalues.dart';
import 'package:weloggerweb/models/models.dart';
import 'package:weloggerweb/products/products.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({Key? key}) : super(key: key);

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    SizeConfig.getDevice();
    return GestureDetector(
        onTap: () {
          pickDateRange();
        },
        child: Obx(() => Container(
              width: SizeConfig.isDesktop! ? SizeConfig.screenWidth! - Values.desktopMenuWidth : SizeConfig.screenWidth,
              height: Values.mobileDatePickerHeight,
              padding: ProjectPadding.horizontalPadding(value: 20),
              margin: ProjectPadding.horizontalPadding(value: 20) + const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: ProjectColors.transparent,
                  border: Border.all(color: ProjectColors.greyColor, width: 1),
                  borderRadius: BorderRadius.circular(Values.contactCardRadius / 2)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    ProjectText.rText(
                        text: '${DateFormat.MMMd().format(controller.startDate.value)} - ',
                        fontSize: Values.fitValue,
                        color: ProjectColors.customColor),
                    ProjectText.rText(
                        text: DateFormat.MMMd().format(controller.endDate.value),
                        fontSize: Values.fitValue,
                        color: ProjectColors.customColor)
                  ],
                ),
                Icon(Icons.date_range, color: ProjectColors.greyColor, size: Values.lValue)
              ]),
            )));
  }
}

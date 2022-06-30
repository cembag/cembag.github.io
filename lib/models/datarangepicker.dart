import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weloggerweb/globalvalues/globalvalues.dart';
import 'package:weloggerweb/products/colors.dart';

DateTimeRange dateRange = DateTimeRange(start: controller.startDate.value, end: controller.endDate.value);

Future pickDateRange() async {
  DateTimeRange? newDateRange = await showDateRangePicker(
    context: Get.context!,
    initialDateRange: dateRange,
    firstDate: DateTime.now().subtract(const Duration(days: 30)),
    lastDate: DateTime.now().add(const Duration(days: 1)),
    cancelText: 'close',
    //configText['close'],
    confirmText: 'confirm',
    //configText['confirm'],
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Colors.greenAccent,
            onPrimary: ProjectColors.themeColorMOD3,
            surface: ProjectColors.themeColorMOD3,
            onSurface: Colors.white,
          ),
          dialogBackgroundColor: ProjectColors.opacityDEFb(0.95),
        ),
        child: child!,
      );
    },
  );
  if (newDateRange == null) {
    return;
  } else {
    controller.startDate.value = newDateRange.start;
    controller.endDate.value = newDateRange.end;
  }
}

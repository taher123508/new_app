import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:news_app/src/Currency/widgets/selectable_list.dart';

import 'package:sizer/sizer.dart';
import 'package:unicons/unicons.dart';

import '../data/default_values.dart';


Padding currencyPickers(
  RxString selectedFrom,
  RxString selectedTo,
  Function() switchCurrencies,
  Function(bool, String) changeSelected,
  ThemeData themeData,
) {
  return Padding(
    padding: paddingV2,
    child: Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          selectableList(selectedFrom.value, true, changeSelected, themeData),
          Padding(
            padding: paddingH1,
            child: GestureDetector(
              onTap: () => switchCurrencies(),
              child: Icon(
                UniconsLine.exchange_alt,
                color: themeData.secondaryHeaderColor,
                size: 22.sp,
              ),
            ),
          ),
          selectableList(selectedTo.value, false, changeSelected, themeData),
        ],
      ),
    ),
  );
}

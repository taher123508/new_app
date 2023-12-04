import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../data/default_values.dart';


Center valueCounter(
  RxString ammount,
  RxString selectedFrom,
  RxString selectedTo,
  RxDouble selectedPrice,
  ThemeData themeData,
) {
  return Center(
    child: Container(
      decoration: BoxDecoration(
        color: themeData.primaryColor.withOpacity(0.45),
        borderRadius: borderRadius1,
      ),
      child: Padding(
        padding: paddingAll1,
        child: Obx(
          () => Text(
            ammount.value.isEmpty
                ? '0,00 $selectedFrom = 0,00 $selectedTo'
                : '${(double.parse(ammount.value.replaceAll(',', '.')).toStringAsFixed(2)).replaceAll('.', ',')} $selectedFrom = ${(double.parse(ammount.value.replaceAll(',', '.')) * selectedPrice.value).toStringAsFixed(2).replaceAll('.', ',')} $selectedTo',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
            ),
          ),
        ),
      ),
    ),
  );
}

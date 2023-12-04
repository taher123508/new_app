import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../data/currencies.dart';
import '../data/default_values.dart';


Center selectableList(String value, bool isFrom,
    Function(bool, String) changeCurr, ThemeData themeData) {
  return Center(
    child: Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: borderRadius1,
        color: themeData.backgroundColor,
        border: Border.all(
          color: themeData.primaryColor,
        ),
      ),
      width: 40.w,
       height: 7.h,
       child:
       DropdownButtonHideUnderline(
         child: DropdownButton<String>(
           hint: const Text(
             'Select',
           ),
           menuMaxHeight: 40.h,

           isExpanded: true,
           dropdownColor: themeData.backgroundColor,
           borderRadius: BorderRadius.circular(10),
           style: GoogleFonts.poppins(color: themeData.primaryColor),
           value: value,
           items: currencies.map(
                 (String item) {
               return DropdownMenuItem<String>(
                 value: item,
                 child: Padding(
                   padding: const EdgeInsets.only(left: 10),
                   child: Text(
                     currencyCountryMap[item] ?? item, // Use Arabic country name if available, else use the English code
                     style: GoogleFonts.lato(
                       color: Colors.white,
                       fontSize: 10.5.sp,
                     ),
                   ),
                 ),
               );
             },
           ).toList(),
           onChanged: (String? value) {
             changeCurr(isFrom, value.toString());
           },
         ),
       ),

    ),
  );
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

AppBar appbarWidget(ThemeData themeData) {
  return AppBar(


    shadowColor: Colors.transparent,
    backgroundColor: themeData.backgroundColor,

    titleSpacing: 0,
    title: Text('تحويل العملات '),

    centerTitle: true,
  );
}

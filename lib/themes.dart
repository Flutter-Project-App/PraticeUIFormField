import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/utils.dart';

ThemeData light(BuildContext context) {
  return ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(color: mainColor),
    scaffoldBackgroundColor: backgroundColor
  );
}

ThemeData dark(BuildContext context) {
  return ThemeData.dark();
}

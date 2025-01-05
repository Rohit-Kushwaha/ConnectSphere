import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFontWeight {
  static const light = FontWeight.w300;
  static const medium = FontWeight.w400;
  static const regular = FontWeight.w500;
}

TextStyle _getTextStyle(
    double fontSize, FontWeight fontWeight, Color textColor) {
  return TextStyle(
      fontSize: fontSize, fontWeight: fontWeight, color: textColor);
}

///Light Style
TextStyle getLightStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, AppFontWeight.light, color);
}

///Medium Style
TextStyle getMediumStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, AppFontWeight.medium, color);
}

///Regular Style
TextStyle getReularStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, AppFontWeight.regular, color);
}

// label : 10, body: 14, title: 16, display: 20, headline: 24
TextStyle merienda10(BuildContext context) {
  return GoogleFonts.merienda(
    textStyle:
        Theme.of(context).textTheme.labelMedium!.copyWith(letterSpacing: 1),
  );
}

TextStyle merienda14(BuildContext context) {
  return GoogleFonts.merienda(
    textStyle:
        Theme.of(context).textTheme.bodyMedium!.copyWith(letterSpacing: 1),
  );
}

TextStyle merienda16(BuildContext context) {
  return GoogleFonts.merienda(
    textStyle:
        Theme.of(context).textTheme.titleMedium!.copyWith(letterSpacing: 1),
  );
}

TextStyle merienda20(BuildContext context) {
  return GoogleFonts.merienda(
    textStyle:
        Theme.of(context).textTheme.displayMedium!.copyWith(letterSpacing: 1),
  );
}

TextStyle merienda24(BuildContext context) {
  return GoogleFonts.merienda(
    textStyle:
        Theme.of(context).textTheme.headlineMedium!.copyWith(letterSpacing: 1),
  );
}

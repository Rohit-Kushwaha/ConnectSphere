import 'package:career_sphere/utils/colors.dart';
import 'package:career_sphere/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData customLightTheme = lightThemeData();
  static ThemeData customDarkTheme = darkThemeData();

  static ThemeData lightThemeData() {
    return ThemeData(
        //** Scaffold Background theme */
        scaffoldBackgroundColor: AppColors.lightScaffold,
        highlightColor: AppColors.whiteColor,
        disabledColor: AppColors.faintBlue,
        //** Icon background color */
        hintColor: AppColors.faintBlue,
        //** Container Card Color */
        canvasColor: AppColors.whiteColor,

        //**Divider Color */
        dividerTheme: const DividerThemeData(
          color: AppColors.lightDivider,
        ),
        secondaryHeaderColor: AppColors.customBlack,

        //**Icon theme */
        iconTheme: const IconThemeData(color: AppColors.lightIcon),

        //** App bar theme */
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: AppColors.lightAppBar,
            foregroundColor: AppColors.blackColor),

        //** Elevated Button Theme */
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightElevated,
          minimumSize: Size(double.infinity, 55.h),
          disabledBackgroundColor: AppColors.lightDisableElevated,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        )),

        //** Input Decoration Theme */
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: AppColors.blackColor),
            borderRadius: BorderRadius.circular(10.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: AppColors.blackColor),
            borderRadius: BorderRadius.circular(10.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: AppColors.blackColor),
            borderRadius: BorderRadius.circular(10.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: AppColors.red),
            borderRadius: BorderRadius.circular(10.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: AppColors.red),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),

        //** Decoration Theme */

        //** Bottom Navigation Theme */
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.lightBottomBar),

        // TextTheme
        textTheme: TextTheme(
          //** in use */
          labelSmall:
              getLightStyle(color: AppColors.blackColor, fontSize: 10.sp),
          labelMedium:
              getMediumStyle(color: AppColors.blackColor, fontSize: 10.sp),
          labelLarge:
              getReularStyle(color: AppColors.blackColor, fontSize: 10.sp),
          //
          bodySmall:
              getLightStyle(color: AppColors.blackColor, fontSize: 14.sp),
          bodyMedium:
              getMediumStyle(color: AppColors.blackColor, fontSize: 14.sp),
          bodyLarge:
              getReularStyle(color: AppColors.blackColor, fontSize: 14.sp),
          //
          titleSmall:
              getLightStyle(color: AppColors.blackColor, fontSize: 16.sp),
          titleMedium:
              getMediumStyle(color: AppColors.blackColor, fontSize: 16.sp),
          titleLarge:
              getReularStyle(color: AppColors.blackColor, fontSize: 16.sp),
          //
          displaySmall:
              getLightStyle(color: AppColors.blackColor, fontSize: 20.sp),
          displayMedium:
              getMediumStyle(color: AppColors.blackColor, fontSize: 20.sp),
          displayLarge:
              getReularStyle(color: AppColors.blackColor, fontSize: 20.sp),
          //
          headlineSmall:
              getLightStyle(color: AppColors.blackColor, fontSize: 24.sp),
          headlineMedium:
              getMediumStyle(color: AppColors.blackColor, fontSize: 24.sp),
          headlineLarge:
              getReularStyle(color: AppColors.blackColor, fontSize: 24.sp),
        ));
  }

  static ThemeData darkThemeData() {
    return ThemeData(
      //** Scaffold Background theme */
      scaffoldBackgroundColor: AppColors.darkScaffold,
      disabledColor: AppColors.customBlack,
      //* Icon background Theme
      hintColor: AppColors.backGroundBlue,
      //**Divider Color */
      dividerTheme: const DividerThemeData(
        color: AppColors.darkDivider,
      ),
      highlightColor: AppColors.whiteColor,
      //** Container Card Color */
      canvasColor: AppColors.darkIndigo,

      //** App bar theme */
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          foregroundColor: AppColors.whiteColor,
          backgroundColor: AppColors.darkAppBar),

      //** Elevated theme */
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkIndigo,
        disabledBackgroundColor: AppColors.textGrey2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      )),

      //** Input Decoration */
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
      //** Icon theme */
      iconTheme: const IconThemeData(color: AppColors.darkIcon),

      //** Bottom Navigation Theme */
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkBottomBar),
      //** TextTheme
      textTheme: TextTheme(
        labelSmall: getLightStyle(color: AppColors.whiteColor, fontSize: 12.sp),
        labelMedium:
            getMediumStyle(color: AppColors.whiteColor, fontSize: 12.sp),
        labelLarge:
            getReularStyle(color: AppColors.whiteColor, fontSize: 12.sp),
        displaySmall:
            getLightStyle(color: AppColors.whiteColor, fontSize: 14.sp),
        bodySmall: getLightStyle(color: AppColors.whiteColor, fontSize: 14.sp),
        bodyMedium:
            getMediumStyle(color: AppColors.whiteColor, fontSize: 14.sp),
        bodyLarge: getReularStyle(color: AppColors.whiteColor, fontSize: 14.sp),
        displayMedium:
            getMediumStyle(color: AppColors.lightBlue, fontSize: 16.sp),
        titleSmall: getLightStyle(color: AppColors.whiteColor, fontSize: 16.sp),
        //* in use
        titleMedium:
            getMediumStyle(color: AppColors.blackColor, fontSize: 16.sp),
        titleLarge:
            getReularStyle(color: AppColors.whiteColor, fontSize: 16.sp),
        displayLarge:
            getReularStyle(color: AppColors.whiteColor, fontSize: 18.sp),
        headlineSmall:
            getLightStyle(color: AppColors.whiteColor, fontSize: 18.sp),
        headlineMedium:
            getMediumStyle(color: AppColors.whiteColor, fontSize: 18.sp),
        headlineLarge:
            getReularStyle(color: AppColors.whiteColor, fontSize: 18.sp),
      ),
    );

    //Container
  }
}

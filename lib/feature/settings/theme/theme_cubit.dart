import 'package:bloc/bloc.dart';
import 'package:career_sphere/data/local/shared/secure_shared_prefs.dart';
import 'package:career_sphere/data/local/shared/shared_prefs.dart';
import 'package:career_sphere/utils/theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(themeMode: AppTheme.lightThemeData()));

  void getSavedTheme() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? mySavedTheme;
    if (mySavedTheme.toString() == "") {
      await SharedPrefHelper.instance.saveData('theme', "lightTheme");

      // await SharedPrefHelper().saveData('theme', 'lightTheme');
    } else {
      mySavedTheme = SharedPrefHelper.instance.getString('theme');
      // mySavedTheme = sharedPreferences.get("theme");
    }
    ThemeData theme;
    if (mySavedTheme == "lightTheme") {
      theme = AppTheme.customLightTheme;
    } else if (mySavedTheme == "darkTheme") {
      theme = AppTheme.customDarkTheme;
    } else {
      theme = AppTheme.customLightTheme;
    }
    emit(ThemeInitial(themeMode: theme));
  }

  Future<void> changeTheme(String themes) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // await sharedPreferences.setString("theme", themes.toString());
    await SharedPrefHelper.instance.saveData('theme', themes.toString());

    ThemeData theme;
    if (themes == "lightTheme") {
      theme = AppTheme.customLightTheme;
    } else if (themes == "darkTheme") {
      theme = AppTheme.customDarkTheme;
    } else {
      theme = AppTheme.customLightTheme;
    }
    emit(ThemeInitial(themeMode: theme));
  }
}

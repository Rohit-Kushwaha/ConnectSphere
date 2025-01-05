import 'package:bloc/bloc.dart';
import 'package:career_sphere/data/local/shared/secure_shared_prefs.dart';
import 'package:career_sphere/data/local/shared/shared_prefs.dart';
import 'package:career_sphere/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(ChangeLanguageState(locale: const Locale('en')));

  void getSavedLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dynamic mySavedLanguage = sharedPreferences.get("language");
    // String? mySavedLanguage = SharedPrefHelper().getData('language') as String?;
    if (mySavedLanguage == null || mySavedLanguage.toString() == '') {
      emit(ChangeLanguageState(locale: const Locale(AppStrings.english)));
    } else {
      emit(ChangeLanguageState(locale: Locale(mySavedLanguage)));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("language", languageCode);
    //  await SharedPrefHelper().saveData('language', languageCode);

    emit(ChangeLanguageState(locale: Locale(languageCode)));
  }
}

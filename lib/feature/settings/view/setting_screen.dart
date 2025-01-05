import 'package:career_sphere/feature/settings/language/language_cubit.dart';
import 'package:career_sphere/feature/settings/theme/theme_cubit.dart';
import 'package:career_sphere/utils/colors.dart';
import 'package:career_sphere/utils/strings.dart';
import 'package:career_sphere/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(children: [_themeMethod(), _languageMethod()]),
          )
        ],
      ),
    );
  }
}

SizedBox _languageMethod() {
  return SizedBox(
    height: 55.h,
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            BlocBuilder<LanguageCubit, LanguageState>(
              builder: (context, state) {
                if (state is ChangeLanguageState) {
                  return state.locale == const Locale(AppStrings.english)
                      ? Text(
                          "English",
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      : Text(
                          "Hindi",
                          style: Theme.of(context).textTheme.titleLarge,
                        );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
        BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            if (state is ChangeLanguageState) {
              return Switch(
                  inactiveTrackColor: AppColors.darkIndigo,
                  value: state.locale == const Locale(AppStrings.english),
                  onChanged: (value) {
                    if (value) {
                      context
                          .read<LanguageCubit>()
                          .changeLanguage(AppStrings.english);
                    } else {
                      debugPrint(state.locale.toString());
                      context
                          .read<LanguageCubit>()
                          .changeLanguage(AppStrings.hindi);
                    }
                  });
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    ),
  );
}

Padding _themeMethod() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.h),
    child: SizedBox(
      height: 55.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  if (state is ThemeInitial) {
                    return state.themeMode == AppTheme.customLightTheme
                        ? Text(
                            "Dark Theme",
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        : Text(
                            "Light Theme",
                            style: Theme.of(context).textTheme.titleLarge,
                          );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              if (state is ThemeInitial) {
                return Switch(
                    inactiveTrackColor: AppColors.darkIndigo,
                    value: state.themeMode == AppTheme.customLightTheme,
                    onChanged: (value) {
                      if (value) {
                        context
                            .read<ThemeCubit>()
                            .changeTheme(AppStrings.lightTheme);
                      } else {
                        debugPrint(state.themeMode.toString());
                        context
                            .read<ThemeCubit>()
                            .changeTheme(AppStrings.darkTheme);
                      }
                    });
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    ),
  );
}

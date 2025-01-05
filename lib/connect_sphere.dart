import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart' as lz;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:career_sphere/feature/settings/language/language_cubit.dart';
import 'package:career_sphere/feature/settings/theme/theme_cubit.dart';
import 'package:career_sphere/utils/routes.dart';

class ConnectSphere extends StatelessWidget {
  const ConnectSphere({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit()..getSavedLanguage(),
      child: BlocProvider(
        create: (context) => ThemeCubit()..getSavedTheme(),
        child: ScreenUtilInit(
          designSize: const Size(430.0, 932.0),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, context) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                if (themeState is ThemeInitial) {
                  return BlocBuilder<LanguageCubit, LanguageState>(
                    builder: (context, state) {
                      if (state is ChangeLanguageState) {
                        return appMaterial(themeState, state);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }

  MaterialApp appMaterial(ThemeInitial themeState, ChangeLanguageState state) {
    return MaterialApp.router(
      routerConfig: router,
      // Adding the navigatorKey here
      // builder: (context, child) => Navigator(
      //   key: navigatorKey, // Setting up the navigator key for external access
      //   onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => child!),
      // ),
      title: 'Connect Sphere',
      debugShowCheckedModeBanner: false,
      theme: themeState.themeMode,
      localizationsDelegates: [
        AppLocalizations.delegate,
        lz.GlobalMaterialLocalizations.delegate,
        lz.GlobalWidgetsLocalizations.delegate,
        lz.GlobalCupertinoLocalizations.delegate,
      ],
      locale: state.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
      ],
    );
  }
}

// Define routes
import 'package:career_sphere/data/local/shared/shared_prefs.dart';
import 'package:career_sphere/feature/bottom_bar/view/bottom_bar.dart';
import 'package:career_sphere/feature/home/blog/view/places.dart';
import 'package:career_sphere/feature/home/items/view/items.dart';
import 'package:career_sphere/feature/home/message/bloc/bloc/message_bloc.dart';
import 'package:career_sphere/feature/home/message/repo/message_repo.dart';
import 'package:career_sphere/feature/home/message/view/message.dart';
import 'package:career_sphere/feature/home/places/view/places.dart';
import 'package:career_sphere/feature/home/profile/view/profile.dart';
import 'package:career_sphere/feature/login/view/login_screen.dart';
import 'package:career_sphere/feature/otp/bloc/bloc/otp_bloc.dart';
import 'package:career_sphere/feature/otp/repo/otp_repo.dart';
import 'package:career_sphere/feature/otp/view/otp_screen.dart';
import 'package:career_sphere/feature/register/view/register.dart';
import 'package:career_sphere/feature/settings/view/setting_screen.dart';
import 'package:career_sphere/feature/splash/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final email =
            state.uri.queryParameters['email'] ?? ''; // Extract the email
        return BlocProvider(
          create: (context) =>
              OtpBloc(OtpRepoImpl())..add(AutomaticOtpSentEvent(email: email)),
          child: OtpScreen(email: email),
        );
      },
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(path: '/home', builder: (context, state) => BottomBar()),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => SettingScreen(),
    ),
    GoRoute(
      path: '/place',
      builder: (context, state) => PlacesScreen(),
    ),
    GoRoute(
      path: '/blog',
      builder: (context, state) => BlogScreen(),
    ),
    GoRoute(
      path: '/message',
      builder: (context, state) {
        return MessageScreen();
      },
    ),
    GoRoute(
      path: '/items',
      builder: (context, state) => ItemsScreen(),
    ),
  ],
);

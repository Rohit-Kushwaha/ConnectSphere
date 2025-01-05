import 'package:career_sphere/data/local/shared/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  final String loginRoute; // Optional, allows dynamic navigation.
  final String homeRoute;

  const SplashScreen(
      {super.key, this.loginRoute = '/login', this.homeRoute = '/home'});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString('accessToken');
    debugPrint("$accessToken accessToken");

    // Check if the accessToken is not null and not empty
    if (accessToken != null && accessToken.isNotEmpty) {
      context.go(widget.homeRoute); // Navigate to the home route
    } else {
      context.go(widget.loginRoute); // Navigate to the login route
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.flutter_dash_rounded,
          color: const Color.fromARGB(255, 5, 139, 249),
          size: 250,
        ),
      ),
    );
  }
}

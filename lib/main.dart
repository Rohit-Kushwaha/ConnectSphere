import 'package:career_sphere/connect_sphere.dart';
import 'package:career_sphere/data/local/shared/shared_prefs.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
   await SharedPrefHelper.instance.init();
  runApp(const ConnectSphere());
}

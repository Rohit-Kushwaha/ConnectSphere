import 'package:career_sphere/connect_sphere.dart';
import 'package:career_sphere/fire.dart';
import 'package:career_sphere/utils/service/notification/notification.dart';
import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  // await Hive.initFlutter(); // Initialize Hive
  // Hive.registerAdapter(WishlistModelAdapter());
  //  await SharedPrefHelper.instance.init();
  //  await Hive.openBox<WishlistModel>('wishlist'); // Open a box for the wishlist
  //  await Firebase.initializeApp(
  // options: DefaultFirebaseOptions.currentPlatform,
// );
  await setupFirebase(); // Call the setup function to initialize everything
  await NotificationService.initializeNotifications();
  runApp(const ConnectSphere()); // Run the app after setup
}

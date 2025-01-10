import 'package:career_sphere/data/local/hive/model/wishlist_model.dart';
import 'package:career_sphere/data/local/shared/shared_prefs.dart';
import 'package:career_sphere/firebase_options.dart';
import 'package:career_sphere/utils/service/notification/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// This function initializes Firebase, sets up messaging, and configures the background message handler.
Future<void> setupFirebase() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive (If needed, include your adapters here)
  await Hive.initFlutter();
  Hive.registerAdapter(WishlistModelAdapter());

  // Initialize Shared Preferences (If needed)
  await SharedPrefHelper.instance.init();
  await Hive.openBox<WishlistModel>('wishlist'); // Open a box for the wishlist

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up Firebase Messaging
  await _setupFirebaseMessaging();
}

// Request notification permissions for iOS devices
Future<void> _requestNotificationPermissions(
    FirebaseMessaging firebaseMessaging) async {
  NotificationSettings settings = await firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    if (kDebugMode) {
      print('User granted permission');
    }
  } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
    if (kDebugMode) {
      print('User denied permission');
    }
  }
}

// Request Android notification permissions
Future<void> _requestNotificationPermissionForAndroid(
    FirebaseMessaging firebaseMessaging) async {
  await firebaseMessaging.requestPermission(
    announcement: true,
    criticalAlert: true,
  );
}

Future<void> _setupFirebaseMessaging() async {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  // Request permissions for iOS devices
  await _requestNotificationPermissions(firebaseMessaging);

  // Request Android-specific permissions
  await _requestNotificationPermissionForAndroid(firebaseMessaging);

  // Get the token each time the application starts
  // String? apnsToken = await firebaseMessaging.getAPNSToken();
  // if (apnsToken != null) {
  //   print("APNS Token: $apnsToken");
  // } else {
  //   print("APNS Token not set.");
  // }

  if (defaultTargetPlatform == TargetPlatform.iOS) {
    // iOS-specific logic (currently no APNs handling as you lack a developer account)
    debugPrint("Running on iOS. Ensure APNs setup if necessary.");
  } else {
    // Logic for Android and other platforms
    String? token = await firebaseMessaging.getToken();
    if (kDebugMode) {
      print("FCM Token: $token");
    }
  }

  // Handle foreground messages (app is in use)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    debugPrint('Received a message in the foreground!');
    if (message.notification != null) {
      debugPrint(
          'Foreground Notification Title: ${message.notification!.title}');
      debugPrint('Foreground Notification Body: ${message.notification!.body}');
      // Show the notification
      await NotificationService.showNotification(message);
    }
  });

  // Handle messages when the app is opened from a terminated state
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('App was opened from a notification');
    if (message.notification != null) {
      debugPrint('Opened Notification Title: ${message.notification!.title}');
      debugPrint('Opened Notification Body: ${message.notification!.body}');
    }
  });

  // Set the background message handler (must be top-level)
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

// Top-level background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");

  // Show a background notification
  await NotificationService.showNotification(message);
}

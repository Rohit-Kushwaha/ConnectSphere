import 'package:app_settings/app_settings.dart';
import 'package:career_sphere/feature/bottom_bar/bloc/bloc/bottom_bar_bloc.dart';
import 'package:career_sphere/feature/bottom_bar/view/side_menu.dart';
import 'package:career_sphere/feature/home/blog/view/places.dart';
import 'package:career_sphere/feature/home/items/view/items.dart';
import 'package:career_sphere/feature/home/message/msg/view/message.dart';
import 'package:career_sphere/feature/home/places/view/places.dart';
import 'package:career_sphere/feature/home/profile/settings/view/profile.dart';
import 'package:career_sphere/utils/menu_app_controller.dart';
import 'package:career_sphere/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with WidgetsBindingObserver {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthorized = false;
  final int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    PlacesScreen(),
    BlogScreen(),
    MessageScreen(),
    ItemsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    // _checkAuthorization();
    super.initState();
  }

  // Check if the user is authorized and device supports biometrics
  Future<void> _checkAuthorization() async {
    bool isBiometricSupported = await auth.canCheckBiometrics;
    bool isBiometricEnrolled =
        await auth.getAvailableBiometrics().then((value) => value.isNotEmpty);
    debugPrint("${isBiometricEnrolled}Biometric");
    debugPrint("${isBiometricSupported}Biometric");

// Check if biometrics are supported and enrolled
    if (!isBiometricSupported || !isBiometricEnrolled) {
      _showEnableBiometricsDialog();
      // Show the bottom sheet if not authorized and biometrics are available
    } else if (isBiometricSupported && !_isAuthorized) {
      _showAuthorizationBottomSheet();
    } else {}
  }

  // Authenticate the user
  Future<void> _authenticate() async {
    try {
      bool isAuthenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access the app',
        options: AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      if (isAuthenticated) {
        setState(() {
          _isAuthorized = true;
        });
        Navigator.pop(context); // Close the bottom sheet
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Authentication failed')),
        );
      }
    } catch (e) {
      debugPrint('Authentication error: $e');
    }
  }

  // Show dialog to enable biometrics or set up a password
  void _showEnableBiometricsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enable Biometrics or Set Up a Password'),
          content: Text(
            'Biometric authentication (fingerprint or face lock) is not set up on your device. '
            'Please enable biometrics or set a password/pin to proceed.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToSettings();
              },
              child: Text('Go to Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Navigate to the device settings to enable biometrics or set a password
  void _navigateToSettings() async {
    // Open device settings
    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        // For Android, open the settings page for biometrics or security
        await AppSettings.openAppSettings(
            type: AppSettingsType.lockAndPassword);
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        // For iOS, open the settings page
        await AppSettings.openAppSettings();
      }
    } catch (e) {
      print('Error opening settings: $e');
    }
  }

  // Show BottomSheet for authorization
  void _showAuthorizationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Authentication Required',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(height: 10),
              Text(
                'Please authenticate using your biometrics to access the app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _authenticate,
                child: Text(
                  'Authenticate',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomBarBloc(),
      child: 
       ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          
        child: Scaffold(
          // key: context.read<MenuAppController>().scaffoldKey,
          appBar: Responsive.isDesktop(context) ? AppBar() : null,
          drawer:
              Responsive.isDesktop(context) ? SideMenu() : SizedBox.shrink(),
          bottomNavigationBar: BlocBuilder<BottomBarBloc, BottomBarState>(
            builder: (context, state) {
              return BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.travel_explore_outlined),
                    label: AppLocalizations.of(context)!.places,
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_max_outlined),
                      label: AppLocalizations.of(context)!.blog),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.message),
                    label: AppLocalizations.of(context)!.message,
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.ice_skating),
                      label: AppLocalizations.of(context)!.items),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.face),
                      label: AppLocalizations.of(context)!.profile),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: state is BottomBarStateChanged
                    ? state.selectedIndex
                    : _selectedIndex,
                selectedItemColor: Colors.amber[800],
                onTap: (selectedIndex) {
                  context
                      .read<BottomBarBloc>()
                      .add(ChangeTabEvent(selectedIndex: selectedIndex));
                },
              );
            },
          ),
          body: BlocBuilder<BottomBarBloc, BottomBarState>(
            builder: (context, state) {
              return Center(
                child: state is BottomBarStateChanged
                    ? _widgetOptions.elementAt(state.selectedIndex)
                    : _widgetOptions.elementAt(_selectedIndex),
              );
            },
          ),
        ),
      ),
    );
  }
}

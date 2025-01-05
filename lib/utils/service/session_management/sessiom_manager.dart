import 'dart:async';

import 'package:flutter/material.dart';

class SessionManager extends StatefulWidget {
  final Widget child; // Accept the child widget (e.g., MaterialApp)

  const SessionManager({super.key, required this.child});

  @override
  State<SessionManager> createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager>
    with WidgetsBindingObserver {
  Timer? _inactivityTimer;
  static const Duration inactivityLimit = Duration(minutes: 2);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startInactivityTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _inactivityTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Reset timer when the app is resumed
      _startInactivityTimer();
    } else if (state == AppLifecycleState.paused) {
      // Stop timer when the app is paused
      _inactivityTimer?.cancel();
    }
  }

  void _startInactivityTimer() {
    _inactivityTimer?.cancel(); // Cancel any existing timer
    _inactivityTimer = Timer(inactivityLimit, _showLogoutDialog);
  }

  void _resetInactivityTimer() {
    _startInactivityTimer();
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Session Timeout"),
        content: const Text(
            "Your session has been inactive. Do you want to logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _startInactivityTimer(); // Restart the timer
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _logout();
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  void _logout() {
    // Perform logout logic here
    Navigator.of(context)
        .pushReplacementNamed('/login'); // Navigate to login screen
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _resetInactivityTimer, // Reset timer on user interaction
      onPanUpdate: (_) => _resetInactivityTimer(),
      child: widget.child, // Render the wrapped child
    );
  }
}

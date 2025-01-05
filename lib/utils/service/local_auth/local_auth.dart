import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthScreen extends StatefulWidget {
  const LocalAuthScreen({super.key});

  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  String _authorized = "Not Authorized";

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    try {
      final bool canCheckBiometrics = await auth.canCheckBiometrics;
      setState(() {
        _canCheckBiometrics = canCheckBiometrics;
      });
    } catch (e) {
      debugPrint("Error checking biometrics: $e");
    }
  }

  Future<void> _authenticate() async {
    try {
      
      final bool authenticated = await auth.authenticate(
        localizedReason: "Scan your fingerprint to authenticate",
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        _authorized = authenticated ? "Authorized" : "Not Authorized";
      });
    } catch (e) {
      debugPrint("Error during authentication: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Authentication"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Can check biometrics: $_canCheckBiometrics",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: const Text("Authenticate"),
            ),
            const SizedBox(height: 20),
            Text(
              "Authentication Status: $_authorized",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
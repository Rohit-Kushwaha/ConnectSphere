import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int second;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.second});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(seconds: second), action);
  }
}

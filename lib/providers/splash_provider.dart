import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashProvider extends ChangeNotifier {
  bool _isReady = false;
  bool get isReady => _isReady;

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    _isReady = true;
    notifyListeners();
  }
}

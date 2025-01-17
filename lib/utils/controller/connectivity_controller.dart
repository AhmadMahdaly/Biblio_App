import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityController {
  /// Private constructor
  ConnectivityController._();

  /// Static instance
  static final ConnectivityController instance = ConnectivityController._();

  /// Notifier for connection status
  /// هي فاليو تمكننا من عمل ليسن
  /// لعمل سويتش بين اليو اي
  ValueNotifier<bool> isConnected = ValueNotifier(
    true,
  );

  /// Initialize connectivity monitoring
  Future<void> init() async {
    final result = await Connectivity().checkConnectivity();
    isInternetConnected(result);
    Connectivity().onConnectivityChanged.listen(isInternetConnected);
  }

  /// Handle connectivity changes
  bool isInternetConnected(ConnectivityResult? result) {
    if (result == ConnectivityResult.none) {
      /// لربطها بالنوتيفاي
      isConnected.value = false;
      return false;
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      /// لربطها بالنوتيفاي
      isConnected.value = true;
      return true;
    }
    return false;
  }
}

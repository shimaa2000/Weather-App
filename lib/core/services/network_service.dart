import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

extension ConnectionStatusExt on InternetConnectionStatus {
  bool get connected => this == InternetConnectionStatus.connected;
  bool get disconnected => this == InternetConnectionStatus.disconnected;
}

class NetworkService {
  NetworkService();

  final _internetChecker = InternetConnectionChecker();
  final _listeners = <StreamSubscription<InternetConnectionStatus>>[];

  Future<bool> get isConnected => _internetChecker.hasConnection;

  void addListener(void Function(InternetConnectionStatus) listener) {
    final listener1 = _internetChecker.onStatusChange.listen(listener);
    _listeners.add(listener1);
  }

  void dispose() {
    for (final listener in _listeners) {
      listener.cancel();
    }
  }
}

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionCheck {
  Future<bool> get isConnected;
}

class ConnectionCheckerImpl implements ConnectionCheck {
  final InternetConnection internetConnection;

  ConnectionCheckerImpl(this.internetConnection);

  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;
}

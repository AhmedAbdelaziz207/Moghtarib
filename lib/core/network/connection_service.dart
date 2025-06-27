// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
// class ConnectionService {
//   static final ConnectionService _instance = ConnectionService._internal();
//   factory ConnectionService() => _instance;
//   ConnectionService._internal();
//
//   final _controller = StreamController<bool>.broadcast();
//
//   Stream<bool> get onConnectivityChanged => _controller.stream;
//
//   void initialize() {
//     Connectivity().onConnectivityChanged.listen((status) async {
//       final hasConnection = await InternetConnectionChecker().hasConnection;
//       _controller.sink.add(hasConnection);
//     });
//   }
//
//   Future<bool> checkConnection() async {
//     return await InternetConnectionChecker().hasConnection;
//   }
//
//   void dispose() {
//     _controller.close();
//   }
// }

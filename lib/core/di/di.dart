import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mo3tarib/core/network/api_service.dart';

import '../network/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Api Service
  Dio dio = await DioFactory.getDio();
  getIt.registerLazySingleton(() => ApiService(dio));


}

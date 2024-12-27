import 'package:get_it/get_it.dart';
import 'package:mo3tarib/core/network/services/webservice.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {

  getIt.registerLazySingleton(() => Webservice());


}

import 'package:dio/dio.dart';
import 'package:mo3tarib/features/department/model/department.dart';
import 'package:mo3tarib/features/login/logic/login_response.dart';
import 'package:mo3tarib/features/register/model/register_repsonse.dart';
import 'package:retrofit/retrofit.dart';
import 'api_endpoints.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiEndPoints.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiEndPoints.login)
  Future<LoginResponse> login(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiEndPoints.register)
  Future<RegisterResponse> register(
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiEndPoints.department)
  Future<List<Department>> getDepartments();
}

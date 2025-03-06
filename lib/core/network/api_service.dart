import 'package:dio/dio.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';
import 'package:mo3tarib/features/department/model/department.dart';
import 'package:mo3tarib/features/login/logic/login_response.dart';
import 'package:mo3tarib/features/register/model/register_repsonse.dart';
import 'package:mo3tarib/features/technicians/model/technicians_model.dart';
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
  Future<RegisterResponse> register(@Body() Map<String, dynamic> body);

  @GET(ApiEndPoints.department)
  Future<List<Department>> getDepartments();

  @GET(ApiEndPoints.technicians)
  Future<List<TechnicalsModel>> getAllTechnicians();

  @GET(ApiEndPoints.apartment)
  Future<List<ApartmentModel>> getApartments();

  @POST(ApiEndPoints.apartment)
  Future<List<ApartmentModel>> addApartment(
    @Body() Map<String, dynamic> apartment,
  );

  @DELETE('${ApiEndPoints.apartment}/{id}')
  Future<List<ApartmentModel>> deleteApartment(@Path() int id);

  @GET(ApiEndPoints.favourite)
  Future<List<ApartmentModel>> getFavouriteApartments();

  @POST(ApiEndPoints.favourite)
  Future<List<ApartmentModel>> addFavouriteApartment(
    @Body() Map<String, dynamic> apartmentId,
  );

  @DELETE('${ApiEndPoints.favourite}/{id}')
  Future<List<ApartmentModel>> deleteFavouriteApartment(
    @Path() int id,
  );
}

import 'package:dio/dio.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/comment_model.dart';
import 'package:mo3tarib/features/chat/model/chat_model.dart';
import 'package:mo3tarib/features/department/model/department.dart';
import 'package:mo3tarib/features/login/logic/login_response.dart';
import 'package:mo3tarib/features/register/model/register_repsonse.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/register/model/user_model.dart';
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

  @GET(ApiEndPoints.apartment)
  Future<List<ApartmentModel>> getApartments({
    @Query("MinPrice") int? minPrice,
    @Query("MaxPrice") int? maxPrice,
    @Query("Distance") int? distance,
    @Query("temp") String? temp,
  });

  @GET(ApiEndPoints.favorites)
  Future<List<ApartmentModel>> getFavoriteApartments();

  @POST(ApiEndPoints.favorites)
  Future<void> addFavoriteApartment(@Body() Map<String, dynamic> id);

  @DELETE(ApiEndPoints.favorites)
  Future<void> removeFavoriteApartment(@Query("ApartmentId") int id);

  @GET(ApiEndPoints.technicians)
  Future<List<UserModel>> getAllTechnicians();

  @GET(ApiEndPoints.allChats)
  Future<List<UserModel>> getAllChas();

  @GET(ApiEndPoints.chat)
  Future<List<ChatMessageModel>> getChat(@Query("receiverId") String id);

  @POST(ApiEndPoints.sendMessage)
  Future<void> sendMessage(@Body() Map<String, dynamic> body);

  @DELETE(ApiEndPoints.deleteChat)
  Future<void> deleteMessage({@Query("MessageID") required String id});

  @GET(ApiEndPoints.user)
  Future<UserModel> getProfile(@Query("userId") String id);

  @GET(ApiEndPoints.comment)
  Future<List<CommentModel>> getApartmentComments(@Query("ApartmentId") int id);

  @POST(ApiEndPoints.addOrDeleteComment)
  Future<void> addApartmentComments(@Body() body);

  @DELETE(ApiEndPoints.addOrDeleteComment)
  Future<void> deleteApartmentComment(@Query("CommentId") int id);

  @POST(ApiEndPoints.sendEmailOTP)
  Future<int> sendEmailOTP(@Query("Email") String email);

  @POST(ApiEndPoints.rate)
  Future<void> addRate(@Body() Map<String, dynamic> body);

  @GET("${ApiEndPoints.rate}/{apartmentId}")
  Future<int> getRate(@Path("apartmentId") int id);

  @PUT(ApiEndPoints.changePassword)
  Future<String> changePassword(@Body() Map<String, dynamic> body);

  @GET(ApiEndPoints.allApartmentForBroker)
  Future<List<ApartmentModel>> getAllApartmentForBroker();

  @DELETE(ApiEndPoints.addApartment)
  Future<ApartmentModel> deleteApartment(@Query("id") int id);
}

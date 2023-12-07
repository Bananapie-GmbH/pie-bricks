import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';

import '../models/user_data/user_data.dart';
part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @POST('/auth/client/signup')
  Future<dynamic> signup(
    @Query("isAnonymous") bool isAnonymous,
  );

  @POST('/auth/client/login')
  Future<dynamic> login(
    @Query("isAnonymous") bool isAnonymous,
  );

  @PUT('/client/update')
  Future<UserData> updateUserData(
    @Body() Map<String, dynamic> body,
  );

  @PUT('/users/update-token')
  Future<dynamic> updateToken(
    @Body() Map<String, dynamic> body,
  );

  @POST('/auth/client/convert-anonymous')
  Future<dynamic> convertAnonymous(
    @Body() Map<String, dynamic> body,
  );

  @GET('/auth/client/me')
  Future<UserData> me();
}

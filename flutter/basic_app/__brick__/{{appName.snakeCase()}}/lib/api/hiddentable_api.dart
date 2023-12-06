import 'package:dio/dio.dart';
import 'package:hiddentable/models/user_data/user_data.dart';

import 'package:retrofit/retrofit.dart';
part 'hiddentable_api.g.dart';

@RestApi()
abstract class HiddentableApi {
  factory HiddentableApi(Dio dio, {String baseUrl}) = _HiddentableApi;

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

  @PUT('/offers/client/view-meal')
  Future<dynamic> mealOfferView(
    @Query("mealId") String? mealId,
  );
  @PUT('/offers/client/view')
  Future<dynamic> offerView(
    @Query("offerId") String? offerId,
  );

  @POST('/restaurant-favorite/add')
  Future<dynamic> addFavorite(
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/restaurant-favorite/remove')
  Future<dynamic> removeFavorite(
    @Query("restaurantId") String? restaurantId,
  );

  @GET('/restaurant/client/reviews')
  Future<dynamic> restaurantReviews(
    @Query("restaurantUserId") String? restaurantUserId,
  );
}

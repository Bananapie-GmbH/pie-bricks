import '../models/user_data/user_data.dart';
import 'api.service.dart';

class AuthenticationService {
  final api = useApi();

  AuthenticationService._();

  static final instance = AuthenticationService._();

  factory AuthenticationService() {
    return instance;
  }

  Future<dynamic> signup({required bool isAnonymous}) async {
    try {
      final response = await api.signup(isAnonymous);
      return response;
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<dynamic> login({required bool isAnonymous}) async {
    try {
      final response = await api.login(isAnonymous);
      return response;
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<UserData> me() async {
    try {
      final response = await api.me();

      return response;
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<dynamic> updateToken(String fcmToken) async {
    try {
      final response = await api.updateToken({"token": fcmToken});

      return response;
    } catch (err) {
      return Future.error(err);
    }
  }

  // Future<UserData> updateUserData({
  //   String? email,
  //   String? firstname,
  //   String? lastname,
  //   String? gender,
  //   String? profilePhotoUrl,
  //   String? phone,
  //   String? address,
  //   String? birthday,
  // }) async {
  //   try {
  //     Map<String, dynamic> data = {};

  //     if (email != null) data["email"] = email;
  //     if (firstname != null) data["firstname"] = firstname;
  //     if (lastname != null) data["lastname"] = lastname;
  //     if (gender != null) data["gender"] = gender;
  //     if (profilePhotoUrl != null) data["profilePhotoUrl"] = profilePhotoUrl;
  //     if (phone != null) data["phone"] = phone;
  //     if (address != null) data["address"] = address;
  //     if (birthday != null) data["birthday"] = birthday;

  //     final response = await api.updateUserData(data);

  //     return response;
  //   } catch (err) {
  //     return Future.error(err);
  //   }
  // }

  // Future<UserData> convertAnonymous({
  //   String? email,
  //   String? firstname,
  //   String? lastname,
  //   String? gender,
  //   String? profilePhotoUrl,
  //   String? phone,
  //   String? address,
  //   String? birthday,
  // }) async {
  //   try {
  //     Map<String, dynamic> data = {};

  //     if (email != null) data["email"] = email;
  //     if (firstname != null) data["firstname"] = firstname;
  //     if (lastname != null) data["lastname"] = lastname;
  //     if (gender != null) data["gender"] = gender;
  //     if (profilePhotoUrl != null) data["profilePhotoUrl"] = profilePhotoUrl;
  //     if (phone != null) data["phone"] = phone;
  //     if (address != null) data["address"] = address;
  //     if (birthday != null) data["birthday"] = birthday;

  //     final response = await api.convertAnonymous(data);

  //     return response;
  //   } catch (err) {
  //     return Future.error(err);
  //   }
  // }
}

AuthenticationService useAuthenticationService() {
  return AuthenticationService();
}

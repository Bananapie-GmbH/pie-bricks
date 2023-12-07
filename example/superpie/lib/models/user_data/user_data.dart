import 'package:json_annotation/json_annotation.dart';

import 'role_profile.dart';
import 'user.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  User? user;
  RoleProfile? roleProfile;

  UserData({this.user, this.roleProfile});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return _$UserDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

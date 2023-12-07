import 'package:json_annotation/json_annotation.dart';

part 'role_profile.g.dart';

@JsonSerializable()
class RoleProfile {
  String? id;
  String? userId;
  String? email;
  String? username;
  String? firstname;
  String? lastname;
  String? gender;
  String? profilePhotoUrl;
  String? phone;
  String? role;
  String? address;
  String? birthday;
  String? uid;
  String? stripeCustomerId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userIdKey;

  RoleProfile({
    this.id,
    this.userId,
    this.email,
    this.username,
    this.firstname,
    this.lastname,
    this.gender,
    this.profilePhotoUrl,
    this.phone,
    this.role,
    this.address,
    this.birthday,
    this.uid,
    this.stripeCustomerId,
    this.createdAt,
    this.updatedAt,
    this.userIdKey,
  });

  factory RoleProfile.fromJson(Map<String, dynamic> json) {
    return _$RoleProfileFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RoleProfileToJson(this);
}

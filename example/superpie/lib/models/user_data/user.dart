import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? email;
  String? password;
  String? uid;
  String? username;
  String? role;
  bool? online;
  dynamic lastLogin;
  dynamic logoutTimestamp;
  String? firebaseMessageToken;
  bool? isAnonymous;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.email,
    this.password,
    this.uid,
    this.username,
    this.role,
    this.online,
    this.lastLogin,
    this.logoutTimestamp,
    this.firebaseMessageToken,
    this.isAnonymous,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

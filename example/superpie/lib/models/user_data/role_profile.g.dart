// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleProfile _$RoleProfileFromJson(Map<String, dynamic> json) => RoleProfile(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      gender: json['gender'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      address: json['address'] as String?,
      birthday: json['birthday'] as String?,
      uid: json['uid'] as String?,
      stripeCustomerId: json['stripeCustomerId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      userIdKey: json['userIdKey'] as String?,
    );

Map<String, dynamic> _$RoleProfileToJson(RoleProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'email': instance.email,
      'username': instance.username,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'gender': instance.gender,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'phone': instance.phone,
      'role': instance.role,
      'address': instance.address,
      'birthday': instance.birthday,
      'uid': instance.uid,
      'stripeCustomerId': instance.stripeCustomerId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'userIdKey': instance.userIdKey,
    };

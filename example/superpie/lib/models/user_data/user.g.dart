// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      uid: json['uid'] as String?,
      username: json['username'] as String?,
      role: json['role'] as String?,
      online: json['online'] as bool?,
      lastLogin: json['lastLogin'],
      logoutTimestamp: json['logoutTimestamp'],
      firebaseMessageToken: json['firebaseMessageToken'] as String?,
      isAnonymous: json['isAnonymous'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'uid': instance.uid,
      'username': instance.username,
      'role': instance.role,
      'online': instance.online,
      'lastLogin': instance.lastLogin,
      'logoutTimestamp': instance.logoutTimestamp,
      'firebaseMessageToken': instance.firebaseMessageToken,
      'isAnonymous': instance.isAnonymous,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

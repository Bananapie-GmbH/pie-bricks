// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination<T> _$PaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Pagination<T>(
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
      count: json['count'] as int?,
      totalPages: json['totalPages'] as int?,
      page: json['page'] as int?,
    );

Map<String, dynamic> _$PaginationToJson<T>(
  Pagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data?.map(toJsonT).toList(),
      'count': instance.count,
      'totalPages': instance.totalPages,
      'page': instance.page,
    };

import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class Pagination<T> {
  List<T>? data;
  int? count;
  int? totalPages;
  int? page;

  Pagination({this.data, this.count, this.totalPages, this.page});

  factory Pagination.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginationFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginationToJson(this, toJsonT);
}

// class AllOffer {
//   List<Offer>? data;
//   int? count;
//   int? totalPages;
//   int? page;

//   AllOffer({this.data, this.count, this.totalPages, this.page});

//   factory AllOffer.fromJson(Map<String, dynamic> json) {
//     return _$AllOfferFromJson(json);
//   }

//   Map<String, dynamic> toJson() => _$AllOfferToJson(this);
// }

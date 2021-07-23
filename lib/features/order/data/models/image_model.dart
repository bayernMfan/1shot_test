import 'package:flutter/material.dart';
import 'package:test_test/features/order/domain/entities/image.dart';

class ImageModel {
  final String? raw;
  final String? full;
  final String? regular;
  final String? small;
  final String? thumb;
  ImageModel({
    @required this.raw,
    @required this.full,
    @required this.regular,
    @required this.small,
    @required this.thumb,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
        raw: json['urls']['raw'] as String,
        full: json['urls']['raw'] as String,
        regular: json['urls']['raw'] as String,
        small: json['urls']['raw'] as String,
        thumb: json['urls']['raw'] as String);
  }
}

extension ImageModelMapper on ImageModel {
  ImageEntity toEntity() => ImageEntity(
      raw: raw.toString(),
      full: full.toString(),
      regular: regular.toString(),
      small: small.toString(),
      thumb: thumb.toString());
}

import 'package:flutter/foundation.dart';

class ImageEntity {
  final String? raw;
  final String? full;
  final String? regular;
  final String? small;
  final String? thumb;
  ImageEntity({
    @required this.raw,
    @required this.full,
    @required this.regular,
    @required this.small,
    @required this.thumb,
  });
}

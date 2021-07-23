import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_test/features/order/domain/entities/image.dart';

class Merch extends Equatable {
  final String? name;
  final ImageEntity? image;
  const Merch({@required this.name, @required this.image});

  @override
  String toString() {
    return '${this.name} ${this.image!.full}';
  }

  @override
  List<Object?> get props => [name, image];
  @override
  bool get stringify => true;
}

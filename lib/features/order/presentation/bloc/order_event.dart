part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class OrderGetMerchs extends OrderEvent {}

class OrderGenerateRandom extends OrderEvent {}

class OrderAddMerch extends OrderEvent {}

class OrderDeleteMerch extends OrderEvent {
  final int _id;
  OrderDeleteMerch(this._id);
  get id => _id;
}

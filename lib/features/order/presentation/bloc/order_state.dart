part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderExamplesGenerated extends OrderState {}

class OrderRandomMerchesGenerating extends OrderState {}

class OrderRandomMerchesGenerated extends OrderState {
  final List<Merch> _merchs;
  OrderRandomMerchesGenerated(this._merchs);
  get merchs => _merchs;
}

class OrderRandomMerchesUpdated extends OrderState {
  final List<Merch> _merchs;
  OrderRandomMerchesUpdated(this._merchs);
  get merchs => _merchs;
}

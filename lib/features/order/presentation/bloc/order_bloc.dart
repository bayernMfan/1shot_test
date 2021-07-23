import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_test/features/order/domain/entities/merch.dart';
import 'package:test_test/features/order/domain/repositrory/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;
  OrderBloc(this.orderRepository) : super(OrderInitial());

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is OrderGetMerchs) {
      await orderRepository.fillMerchList();
      yield OrderExamplesGenerated();
    } else if (event is OrderGenerateRandom) {
      yield OrderRandomMerchesGenerating();
      generateRandomMerches(orderRepository.merchExamples);
      yield OrderRandomMerchesGenerated(
          orderRepository.randomMerchandises.reversed.toList());
    } else if (event is OrderDeleteMerch) {
      deleteMerch(event.id);
      yield OrderRandomMerchesUpdated(
          orderRepository.randomMerchandises.reversed.toList());
    } else if (event is OrderAddMerch) {
      addMerch(orderRepository.merchExamples);
      yield OrderRandomMerchesUpdated(
          orderRepository.randomMerchandises.reversed.toList());
    }
  }

  Merch generateRandomMerch(List<Merch> examples) =>
      orderRepository.getRandomMerch(examples);

  List<Merch> generateRandomMerches(List<Merch> examples) {
    int count = new Random().nextInt(9000) + 1000;
    orderRepository.fillRandomMerches(count, examples);
    return orderRepository.randomMerchandises;
  }

  void deleteMerch(int index) => orderRepository.deleteMerch(index);
  void addMerch(List<Merch> examples) => orderRepository.addMerch(examples);
}

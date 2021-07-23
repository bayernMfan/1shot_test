import 'package:test_test/features/order/domain/entities/image.dart';
import 'package:test_test/features/order/domain/entities/merch.dart';

abstract class OrderRepository {
  Future<ImageEntity> getMerchImage(String? imageId);
  Merch getRandomMerch(List<Merch> examples);

  Future<void> fillMerchList();
  void fillRandomMerches(int count, List<Merch> examples);

  List<Merch> get merchExamples;
  List<Merch> get randomMerchandises;

  void deleteMerch(int id);
  void addMerch(List<Merch> examples);
}

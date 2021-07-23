import 'dart:math';

import 'package:test_test/features/order/data/datasources/order_datasource.dart';
import 'package:test_test/features/order/data/models/image_model.dart';
import 'package:test_test/features/order/domain/entities/image.dart';
import 'package:test_test/features/order/domain/entities/merch.dart';
import 'package:test_test/features/order/domain/repositrory/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource _dataSource;
  OrderRepositoryImpl(this._dataSource);

  final List<Merch> _merchesExamples = [];
  List<Merch> _randomMerchandises = [];

  @override
  Future<ImageEntity> getMerchImage(String? imageId) async {
    final model = await _dataSource.getMerchImage(imageId);
    final ImageEntity image = model.toEntity();
    return image;
  }

  @override
  Future<void> fillMerchList() async {
    Map<String, String> merchs = {
      'Coca-Cola': '/z8PEoNIlGlg',
      'Sprite': '/oUUBhKsQtFo',
      'Pepsi': '/CqY5To2ZU8E',
      'Carlsberg': '/PIP0uBdX5V8'
    };
    for (MapEntry entry in merchs.entries) {
      ImageEntity entity = await getMerchImage(entry.value);
      _merchesExamples.add(Merch(name: entry.key, image: entity));
    }
    return;
  }

  @override
  Merch getRandomMerch(List<Merch> examples) {
    int _randomIndex = new Random().nextInt(examples.length);
    return examples.elementAt(_randomIndex);
  }

  @override
  void fillRandomMerches(int count, List<Merch> examples) =>
      _randomMerchandises =
          List.generate(count, (index) => getRandomMerch(examples));

  @override
  List<Merch> get merchExamples => this._merchesExamples;

  @override
  List<Merch> get randomMerchandises => this._randomMerchandises;

  @override
  void addMerch(List<Merch> examples) =>
      _randomMerchandises.add(getRandomMerch(examples));

  @override
  void deleteMerch(int id) =>
      _randomMerchandises.removeAt(_randomMerchandises.length - 1 - id);
}

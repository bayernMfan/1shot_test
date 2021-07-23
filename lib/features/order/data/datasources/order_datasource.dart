import 'package:test_test/features/order/data/api/order_api.dart';
import 'package:test_test/features/order/data/models/image_model.dart';

class OrderDataSource {
  final OrderApi _orderApi = OrderApi();
  Future<ImageModel> getMerchImage(String? imageId) async {
    dynamic response = await _orderApi.getMerchImage(imageId);
    final ImageModel result = ImageModel.fromJson(response);
    return result;
  }
}

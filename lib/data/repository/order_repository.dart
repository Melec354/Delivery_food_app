import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/models/place_order_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

class OrderRepository {
  final ApiClient apiClient;

  OrderRepository({required this.apiClient});

  Future<Response> placeOrder(PlaceOrderBody placeOrderBody) async {
    return await apiClient.postData(
        AppConstants.placeOrderURL, placeOrderBody.toJson());
  }

  Future<Response> getOrderList() async {
    return await apiClient.getData(AppConstants.orderListURL);
  }
}

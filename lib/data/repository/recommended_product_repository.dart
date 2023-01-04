import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RecommendedProductRepository extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepository({required this.apiClient});

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.recommendedURL);
  }
}

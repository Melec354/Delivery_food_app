import 'package:food_app/controllers/auth_contoller.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/controllers/order_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_product_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/data/repository/auth_repository.dart';
import 'package:food_app/data/repository/cart_repository.dart';
import 'package:food_app/data/repository/location_repository.dart';
import 'package:food_app/data/repository/order_repository.dart';
import 'package:food_app/data/repository/popular_product_repository.dart';
import 'package:food_app/data/repository/recommended_product_repository.dart';
import 'package:food_app/data/repository/user_repository.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  //Popular product
  Get.lazyPut(() => PopularProductRepository(apiClient: Get.find()));
  Get.lazyPut(
      () => PopularProductController(popularProductRepository: Get.find()));

  //Recomemnded product
  Get.lazyPut(() => RecommendedProductRepository(apiClient: Get.find()));
  Get.lazyPut(() =>
      RecommendedProductController(recommendedProductRepository: Get.find()));

  //Cart
  Get.lazyPut(() => CartRepository(sharedPreferences: Get.find()));
  Get.lazyPut(() => CartController(cartRepository: Get.find()));

  //Auth
  Get.lazyPut(() =>
      AuthRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthController(authRepository: Get.find()));

  //User
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));

  //location
  Get.lazyPut(() =>
      LocationRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationController(locationRepository: Get.find()));

  //orders
  Get.lazyPut(() => OrderRepository(apiClient: Get.find()));
  Get.lazyPut(() => OrderController(orderRepository: Get.find()));
}

import 'package:food_app/models/order_model.dart';
import 'package:food_app/pages/address/add_address_page.dart';
import 'package:food_app/pages/address/pick_address_map.dart';
import 'package:food_app/pages/auth/sign_in_page.dart';
import 'package:food_app/pages/cart/cart_page.dart';
import 'package:food_app/pages/food/popular_food_detail.dart';
import 'package:food_app/pages/food/recommended_food_detail.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/pages/payment/payment_page.dart';
import 'package:food_app/pages/splash/splash_page.dart';
import 'package:get/route_manager.dart';

import '../pages/home/home_page.dart';
import '../pages/payment/order_succes_page.dart';

class RouteHelper {
  static const String splashScreen = '/splash-screen';
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String signIn = '/sign-in';
  static const String addAddress = '/address';
  static const String pickAddressMap = '/pick-address-map';

  static const String payment = '/payment';
  static const String orderSuccess = '/order-success';

  static String getSplashScreen() => splashScreen;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => cartPage;
  static String getSignInPage() => signIn;
  static String getAddressPage() => addAddress;
  static String getPickAddressPage() => pickAddressMap;

  static String getPaymentPage(String id, int userId) =>
      '$payment?id=$id&userId=$userId';
  static String getOrderSuccessPage(String orderId, String status) =>
      '$orderSuccess?id=$orderId&status=$status';

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(
        name: signIn,
        page: () => const SignInPage(),
        transition: Transition.fade),
    GetPage(
        transition: Transition.fadeIn,
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(
            pageId: int.parse(pageId!),
            page: page!,
          );
        }),
    GetPage(
        transition: Transition.fadeIn,
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetail(
            pageId: int.parse(pageId!),
            page: page!,
          );
        }),
    GetPage(
        transition: Transition.fadeIn,
        name: cartPage,
        page: () {
          return const CartPage();
        }),
    GetPage(name: addAddress, page: () => const AddAddressPage()),
    GetPage(
        name: pickAddressMap,
        page: () {
          PickAddressMap _pickAddress = Get.arguments;
          return _pickAddress;
        }),
    GetPage(
        name: payment,
        page: () => PaymentPage(
            orderModel: OrderModel(
                id: int.parse(Get.parameters['id']!),
                userId: int.parse(Get.parameters['userId']!)))),
    GetPage(
        name: orderSuccess,
        page: () => OrderSuccessPage(
            orderId: Get.parameters['id']!,
            status: Get.parameters['status'].toString().contains('success')
                ? 1
                : 0)),
  ];
}

import 'package:get/get.dart';

bool isIOS = GetPlatform.isIOS;
bool isAndroid = GetPlatform.isAndroid;

class AppConstants {
  static const String appName = 'BestFood';
  static const int appVersion = 1;

  // static const String baseUrl = 'https://ig-food-menus.herokuapp.com';

  // static const String popularURL = '/best-foods';
  // static const String recommendedURL = '/bbqs';

  // static const String baseUrl = 'http://127.0.0.1:8000';
  static final String baseUrl =
      isAndroid ? 'http://10.0.2.2:8000' : 'http://127.0.0.1:8000';

  static const String popularURL = '/api/v1/products/popular';
  static const String recommendedURL = '/api/v1/products/recommended';
  static const String drinksURL = '/api/v1/products/drinks';
  static const String uploadURL = '/uploads/';

  static const String userInfoURL = '/api/v1/customer/info';

  static const String registrationURL = '/api/v1/auth/register';
  static const String loginURL = '/api/v1/auth/login';
  static const String token = 'token';

  static const String phone = '';
  static const String password = '';

  static const String cartList = 'cart-list';
  static const String cartHistoryList = 'cart-history-list';

  static const String geocodeURL = '/api/v1/config/geocode-api';

  static const String userAddress = 'user_address';
  static const String addUserAddress = '/api/v1/customer/address/add';
  static const String addressListURL = '/api/v1/customer/address/list';

  static const String zoneURL = '/api/v1/config/get-zone-id';

  static const String searchLocationURL =
      '/api/v1/config/place-api-autocomplete';
  static const String placeDetailURL = '/api/v1/config/place-api-details';

  static const String placeOrderURL = '/api/v1/customer/order/place';
  static const String orderListURL = '/api/v1/customer/order/list';
}

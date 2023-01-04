import 'dart:convert';

import 'package:food_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepository {
  final SharedPreferences sharedPreferences;

  CartRepository({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void clearRep() {
    sharedPreferences.clear();
  }

  void addToCarList(List<CartModel> cartList) {
    String time = DateTime.now().toString();
    cart = [];
    cartList.forEach((element) {
      element.time = time;
      cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.cartList, cart);
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.cartList)) {
      carts = sharedPreferences.getStringList(AppConstants.cartList)!;
    }
    List<CartModel> cartList = [];
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartList;
  }

  List<CartModel> getCartHistory() {
    if (sharedPreferences.containsKey(AppConstants.cartHistoryList)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
    }

    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartListHistory;
  }

  void addToCartHistotyList() {
    if (sharedPreferences.containsKey(AppConstants.cartHistoryList)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
    }
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    cart = [];
    sharedPreferences.setStringList(AppConstants.cartHistoryList, cartHistory);
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.cartList);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.cartHistoryList);
  }

  void removeCartSharedPreference() {
    sharedPreferences.remove(AppConstants.cartList);
    sharedPreferences.remove(AppConstants.cartHistoryList);
  }
}

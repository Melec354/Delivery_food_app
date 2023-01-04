import 'package:flutter/material.dart';
import 'package:food_app/data/repository/cart_repository.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepository cartRepository;

  CartController({required this.cartRepository});
  Map<String, CartModel> _items = {};
  Map<String, CartModel> get items => _items;
  List<CartModel> storageItems = [];
  void addItem(ProductModel productModel, int quantity) {
    int totalQuantity = 0;
    if (_items.containsKey(productModel.id!)) {
      _items.update(productModel.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id,
            img: value.img,
            name: value.name,
            price: value.price,
            quantity: value.quantity! + quantity,
            isExist: true,
            time: DateTime.now().toString(),
            productModel: productModel);
      });

      if (totalQuantity <= 0) {
        items.remove(productModel.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(
            productModel.id!,
            () => CartModel(
                id: productModel.id,
                img: productModel.img,
                name: productModel.name,
                price: productModel.price,
                quantity: quantity,
                isExist: true,
                time: DateTime.now().toString(),
                productModel: productModel));
      } else {
        Get.snackbar(
            'Item count', 'You should at least add an item in the cart',
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    cartRepository.addToCarList(getItems);
    update();
  }

  bool existInCart(ProductModel productModel) {
    if (_items.containsKey(productModel.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel productModel) {
    int quantity = 0;
    if (_items.containsKey(productModel.id)) {
      _items.forEach((key, value) {
        if (key == productModel.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    int totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepository.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(
          storageItems[i].productModel!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepository.addToCartHistotyList();
    clearItems();
  }

  void clearItems() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepository.getCartHistory();
  }

  set setItems(Map<String, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepository.addToCarList(getItems);
    update();
  }

  void clearRepo() {
    cartRepository.clearRep();
  }

  void clearCartHistory() {
    cartRepository.clearCartHistory();
    update();
  }

  void removeCartSharedPreference() {
    cartRepository.removeCartSharedPreference();
  }
}

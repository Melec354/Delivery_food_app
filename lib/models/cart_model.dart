import 'package:food_app/models/product_model.dart';

class CartModel {
  String? id;
  String? img;
  String? name;
  double? price;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? productModel;

  CartModel(
      {this.id,
      this.img,
      this.name,
      this.price,
      this.quantity,
      this.isExist,
      this.time,
      this.productModel});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    name = json['name'];
    price = double.parse(json['price'].toString());
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    productModel = ProductModel.fromJson(json['productModel']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img': img,
      'name': name,
      'price': price,
      'quantity': quantity,
      'isExist': isExist,
      'time': time,
      'productModel': productModel!.toJson(),
    };
  }
}

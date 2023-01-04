class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel>? _products;
  List<ProductModel>? get products => _products;

  Product(
      {required totalSize,
      required typeId,
      required offset,
      required products}) {
    _totalSize = totalSize;
    _typeId = typeId;
    _offset = offset;
    _products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products!.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  String? id;
  String? name;
  String? dsc;
  double? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductModel(
      {this.id,
      this.name,
      this.dsc,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    dsc = json['description'];
    price = double.parse(json['price'].toString());
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = dsc;
    data['price'] = price;
    data['stars'] = stars;
    data['img'] = img;
    data['location'] = location;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type_id'] = typeId;
    return data;
  }
}



// class ProductModel {
//   String? id;
//   String? img;
//   String? name;
//   String? dsc;
//   double? price;
//   int? rate;
//   String? country;

//   ProductModel(
//       {this.id,
//       this.img,
//       this.name,
//       this.dsc,
//       this.price,
//       this.rate,
//       this.country});

//   ProductModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     img = json['img'];
//     name = json['name'];
//     dsc = json['dsc'];
//     price = double.parse(json['price'].toString());
//     rate = json['rate'];
//     country = json['country'];
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'img': img,
//       'name': name,
//       'price': price,
//       'dsc': dsc,
//       'rate': rate,
//       'country': country
//     };
//   }
// }

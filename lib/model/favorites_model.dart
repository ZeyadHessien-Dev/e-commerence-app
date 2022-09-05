class FavoritesModel {
  bool? status;
  String? message;
  FavoritesDataModel? data;


  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? FavoritesDataModel.fromJson(json['data']) : null;
  }

}

class FavoritesDataModel {
  int? id;
  FavoritesProductModel? product;


  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? FavoritesProductModel.fromJson(json['product']) : null;
  }

}

class FavoritesProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;


  FavoritesProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }

}
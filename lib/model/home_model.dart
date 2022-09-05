class HomeModel {
  bool? status;
  dynamic message;
  HomeDataModel? data;


  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
  }

}

class HomeDataModel {
  List<HomeBannersModel>? banners;
  List<HomeProductsModel>? products;
  String? ad;


  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <HomeBannersModel>[];
      json['banners'].forEach((v) {
        banners!.add(HomeBannersModel.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <HomeProductsModel>[];
      json['products'].forEach((v) {
        products!.add(HomeProductsModel.fromJson(v));
      });
    }
    ad = json['ad'];
  }

}

class HomeBannersModel {
  int? id;
  String? image;
  dynamic category;
  dynamic product;


  HomeBannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }

}

class HomeProductsModel {
  int? id;
  var price;
  var oldPrice;
  var discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;


  HomeProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}
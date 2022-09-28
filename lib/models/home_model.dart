class HomeDataModel{
  bool? status;
  String? message;
  DataModel? data;

  HomeDataModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = DataModel.fromJson(json['data']);
  }

}

class DataModel{
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  String? ad;
  DataModel.fromJson(Map<String, dynamic> json){
    ad = json['ad'];

    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element){
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel{
  int? id;
  String? image;
  String? category;
  ProductModel? product;
  BannerModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    category = json['category'];
  }

}

class ProductModel{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<dynamic> images = [];
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
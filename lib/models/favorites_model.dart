// ignore_for_file: prefer_typing_uninitialized_variables

class FavoriteModel{
  bool? status;
  String? message;
  FavoriteData? data;

  FavoriteModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = FavoriteData.fromJson(json['data']);
  }
}

class FavoriteData{
  int? currentPage;
  String? firstPageURL, lastPageURL, nextPageURL, prevPageURL, path;
  int? from, to, perPage, total, lastPage;
  Data? data;

  FavoriteData.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    firstPageURL = json["first_page_url"];
    from = json["from"];
    lastPage = json["last_page"];
    lastPageURL = json["last_page_url"];
    nextPageURL = json["next_page_url"];
    path = json["path"];
    perPage = json["per_page"];
    prevPageURL = json["prev_page_url"];
    to = json["to"];
    total = json["total"];
    data = Data.fromJson(json["data"]);
  }
}

class Data{
  List<FavoriteProduct> data = [];
  Data.fromJson(dynamic json){
    json.forEach(
        (element){
          data.add(FavoriteProduct.fromJson(element));
        }
    );
  }
}

class FavoriteProduct{
  var id;
  Product? product;
  FavoriteProduct.fromJson(Map<String, dynamic> json){
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product{
  var id, discount;
  String? image, name, description;
  var price, oldPrice;
  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
  }
}
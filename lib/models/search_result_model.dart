class SearchResultModel{
  bool? status;
  String? message;
  Data? data;
  SearchResultModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}
class Data{
  var currentPage;
  var firstPageURL, lastPageURL, nextPageURL, prevPageURL, path;
  var from, to, perPage, total, lastPage;
  List<Product> searchResult = [];

  Data.fromJson(Map<String, dynamic> json){
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
    json["data"].forEach((element) => {searchResult.add(Product.fromJson(element))});
  }
}

class Product{
  bool? inFavorites, inCart;
  var id;
  var price, oldPrice, discount;
  String? image, name, description;
  List<String> images = [];

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    json['images'].forEach((element) => images.add(element),);
  }
}
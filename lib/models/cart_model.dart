class CartModel{
  bool? status;
  String? message;
  Data? data;


  CartModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);

  }

}

class Data{
  var subTotal, total;
  List<Order> cartItems = [];
  Data.fromJson(Map<String, dynamic> json){
    subTotal = json['sub_total'];
    total = json['total'];
    json['cart_items'].forEach((element) => cartItems.add(Order.fromJson(element)));
  }
}

class Order{
  int? id, quantity;
  Product? product;
  Order.fromJson(Map<String, dynamic> json){
    id = json['id'];
    quantity = json['quantity'];
    product = Product.fromJson(json['product']);
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
    oldPrice = json['old_price'];
    discount = json['discount'];
    json['images'].forEach((element) => images.add(element),);
  }
}
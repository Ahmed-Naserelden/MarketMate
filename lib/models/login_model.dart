class ShopLoginModel{
  late bool status;
  late String message;
  UserData? data;

  ShopLoginModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = status == true ? UserData.fromJson(json['data']) : null;
  }
}


class UserData{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late String token;
  late int credit;

  UserData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    token = json['token'];
    credit = json['credit'];
  }
}



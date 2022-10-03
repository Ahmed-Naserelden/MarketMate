class ChangeFavoriteModel{
  String? message;
  bool? status;
  ChangeFavoriteModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    status = json['status'];
  }

}
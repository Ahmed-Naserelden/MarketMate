class CategoriesModel{
  bool? status;
  String? message;
  CategoriesData? categoriesData;
  CategoriesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    categoriesData = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData{
  int? currentPage;      // current_page
  List<Data> data = [];
  String? firstPageURL;
  String? lastPageURL;
  String? nextPageURL;
  int? perPage;
  String? prevPageURL;
  int? from;
  int? to;
  int? total;
  String? path;

  CategoriesData.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element) => data.add(Data.fromJson(element)) );

    firstPageURL = json['first_page_url'];
    lastPageURL = json['last_page_url'];
    nextPageURL = json['next_page_url'];
    perPage = json['per_page'];
    prevPageURL = json['prev_page_url'];
    to = json['to'];
    from = json['from'];
    total = json['total'];
    path = json['path'];

  }


}

class Data{
  int? id;
  String? name;
  String? image;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}
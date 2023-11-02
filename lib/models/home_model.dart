class HomeModel
{
  bool? status;
  HomeDataModel? data;
//named constructor
  HomeModel.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel
{
  List<BannerModel>? banners =[] ;
  List<ProductModel>? products =[];
//named constructor
  HomeDataModel.fromJson(Map<String , dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners!.add(BannerModel.fromJson(element));
    });
    json['home'].forEach((element)
    {
      products!.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel
{
  late int id;
  late String image;
  //named constructor
  BannerModel.fromJson(Map< String? , dynamic> json)
  {
    id = json ['id'];
    image = json ['image'];
  }
}

class ProductModel
{
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;
  //named constructor
  ProductModel.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];

  }
}
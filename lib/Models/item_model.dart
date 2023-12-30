class Item {
  String? sId;
  String? name;
  String? description;
  String? image;
  double? rating;
  int? ratingCount;
  double? price;
  List<String>? vitamins;
  List<String>? ingrediants;
  String? categoryId;

  Item({
    this.sId,
    this.name,
    this.description,
    this.image,
    this.rating,
    this.ratingCount,
    this.price,
    this.vitamins,
    this.ingrediants,
    this.categoryId,
  });

  Item.fromJson(Map<String, dynamic> json, String id) {
    sId = id;
    name = json['name'];
    description = json['description'];
    image = json['image'];
    rating = double.tryParse(json['rating']) ?? 0.0;
    ratingCount = int.parse(json['ratingCount']);
    price = double.tryParse(json['price']) ?? 0.0;
    vitamins = json['vitamins'].cast<String>();
    ingrediants = json['ingrediants'].cast<String>();
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['rating'] = rating;
    data['ratingCount'] = ratingCount;
    data['price'] = price;
    data['vitamins'] = vitamins;
    data['ingrediants'] = ingrediants;
    data['categoryId'] = categoryId;

    return data;
  }
}

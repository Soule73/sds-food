class Favori {
  String? itemId;
  String? userId;

  Favori({this.itemId});

  Favori.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    itemId = json['itemId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['itemId'] = itemId;
    return data;
  }
}

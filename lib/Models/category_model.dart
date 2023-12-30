class Category {
  String? sId;
  String? name;
  String? icon;

  Category({this.sId, this.name, this.icon});

  Category.fromJson(Map<String, dynamic> json, String id) {
    sId = id;
    name = json['name'];
    icon = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = sId;
    data['name'] = name;
    data['imageUrl'] = icon;
    return data;
  }
}

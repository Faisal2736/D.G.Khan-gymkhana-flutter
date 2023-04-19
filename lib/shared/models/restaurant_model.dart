import 'dart:convert';

RestaurantModel restaurantModelFromJson(String str) =>
    RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) =>
    json.encode(data.toJson());

class RestaurantModel {
  RestaurantModel({
    this.resId,
    this.name,
    this.kotp,
    this.billP,
    this.takeaway,
    this.icon,
  });

  RestaurantModel.fromJson(dynamic json) {
    resId = json['resId'];
    name = json['name'];
    kotp = json['kotp'];
    billP = json['billP'];
    takeaway = json['takeaway'];
    icon = json['icon'];
  }

  num? resId;
  String? name;
  String? kotp;
  String? billP;
  bool? takeaway;
  String? icon;

  RestaurantModel copyWith({
    num? resId,
    String? name,
    String? kotp,
    String? billP,
    bool? takeaway,
    String? icon,
  }) =>
      RestaurantModel(
        resId: resId ?? this.resId,
        name: name ?? this.name,
        kotp: kotp ?? this.kotp,
        billP: billP ?? this.billP,
        takeaway: takeaway ?? this.takeaway,
        icon: icon ?? this.icon,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resId'] = resId;
    map['name'] = name;
    map['kotp'] = kotp;
    map['billP'] = billP;
    map['takeaway'] = takeaway;
    map['icon'] = icon;
    return map;
  }
}

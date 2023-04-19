import 'dart:convert';

MenuItemModel menuItemModelFromJson(String str) =>
    MenuItemModel.fromJson(json.decode(str));

String menuItemModelToJson(MenuItemModel data) => json.encode(data.toJson());

class MenuItemModel {
  MenuItemModel({
    this.code,
    this.name,
    this.priceF,
    this.priceH,
    this.priceS,
    this.xlarge,
    this.showF,
    this.showH,
    this.showS,
  });

  MenuItemModel.fromJson(dynamic json) {
    code = json['code'];
    name = json['name'];
    priceF = json['priceF'];
    priceH = json['priceH'];
    priceS = json['priceS'];
    xlarge = json['xlarge'];
    showF = json['showF'];
    showH = json['showH'];
    showS = json['showS'];
  }

  num? code;
  String? name;
  String? showF;
  String? showH;
  String? showS;
  num? priceF;
  num? priceH;
  num? priceS;
  dynamic xlarge;

  MenuItemModel copyWith({
    num? code,
    String? name,
    String? showF,
    String? showH,
    String? showS,
    num? priceF,
    num? priceH,
    num? priceS,
    dynamic xlarge,
  }) =>
      MenuItemModel(
        code: code ?? this.code,
        name: name ?? this.name,
        priceF: priceF ?? this.priceF,
        priceH: priceH ?? this.priceH,
        priceS: priceS ?? this.priceS,
        xlarge: xlarge ?? this.xlarge,
        showF: showF ?? this.showF,
        showH: showH ?? this.showH,
        showS: showS ?? this.showS,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['name'] = name;
    map['priceF'] = priceF;
    map['priceH'] = priceH;
    map['priceS'] = priceS;
    map['xlarge'] = xlarge;
    map['showF'] = showF;
    map['showH'] = showH;
    map['showS'] = showS;
    return map;
  }
}

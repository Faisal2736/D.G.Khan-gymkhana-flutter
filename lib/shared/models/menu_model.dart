import 'dart:convert';

MenuModel menuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
  MenuModel({
    this.resId,
    this.menuid,
    this.mainHead,
    this.icon,
  });

  MenuModel.fromJson(dynamic json) {
    resId = json['resId'];
    menuid = json['menuid'];
    mainHead = json['mainHead'];
    icon = json['icon'];
  }

  num? resId;
  num? menuid;
  String? mainHead;
  String? icon;

  MenuModel copyWith({
    num? resId,
    num? menuid,
    String? mainHead,
    String? icon,
  }) =>
      MenuModel(
        resId: resId ?? this.resId,
        menuid: menuid ?? this.menuid,
        mainHead: mainHead ?? this.mainHead,
        icon: icon ?? this.icon,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['resId'] = resId;
    map['menuid'] = menuid;
    map['mainHead'] = mainHead;
    map['icon'] = icon;
    return map;
  }
}

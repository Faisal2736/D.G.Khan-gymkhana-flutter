import 'dart:convert';

CartDetailsModel cartDetailsModelFromJson(String str) =>
    CartDetailsModel.fromJson(json.decode(str));

String cartDetailsModelToJson(CartDetailsModel data) =>
    json.encode(data.toJson());

class CartDetailsModel {
  CartDetailsModel({
    this.cdate,
    this.tableServiceCharges,
    this.takeAwayCharges,
    this.isTakeAway,
    this.tableNo,
    this.resId,
    this.phone,
    this.name,
    this.customerId,
  });

  CartDetailsModel.fromJson(dynamic json) {
    cdate = json['cdate'];
    tableServiceCharges = json['tableServiceCharges'];
    takeAwayCharges = json['takeAwayCharges'];
    isTakeAway = json['isTakeAway'];
    tableNo = json['tableNo'];
    resId = json['resId'];
    phone = json['phone'];
    name = json['name'];
    customerId = json['customerId'];
  }

  String? cdate;
  num? tableServiceCharges ;
  num? takeAwayCharges ;
  bool? isTakeAway;
  String? tableNo;
  num? resId;
  String? phone;
  String? name;
  String? customerId;

  CartDetailsModel copyWith({
    String? cdate,
    bool? isTakeAway,
    String? tableNo,
    num? resId,
    String? phone,
    String? name,
    String? customerId,
  }) =>
      CartDetailsModel(
        cdate: cdate ?? this.cdate,
        isTakeAway: isTakeAway ?? this.isTakeAway,
        tableNo: tableNo ?? this.tableNo,
        resId: resId ?? this.resId,
        phone: phone ?? this.phone,
        name: name ?? this.name,
        customerId: customerId ?? this.customerId,
      );

  @override
  String toString() {
    return 'CartDetailsModel{cdate: $cdate, isTakeAway: $isTakeAway, tableNo: $tableNo, resId: $resId, phone: $phone, name: $name, customerId: $customerId}';
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cdate'] = cdate;
    map['isTakeAway'] = isTakeAway;
    map['tableNo'] = tableNo;
    map['resId'] = resId;
    map['phone'] = phone;
    map['name'] = name;
    map['customerId'] = customerId;
    return map;
  }
}

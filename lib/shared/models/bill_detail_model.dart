import 'dart:convert';

BillDetailModel billDetailModelFromJson(String str) =>
    BillDetailModel.fromJson(json.decode(str));

String billDetailModelToJson(BillDetailModel data) =>
    json.encode(data.toJson());

class BillDetailModel {
  BillDetailModel({
    this.tableNo,
    this.restaurantName,
    this.noofPersons,
    this.billId,
    this.cdate,
    this.items,
    this.totalBill,
    this.service,
  });

  BillDetailModel.fromJson(dynamic json) {
    tableNo = json['tableNo'];
    restaurantName = json['restaurantName'];
    noofPersons = json['noofPersons'];
    billId = json['billId'];
    cdate = json['cdate'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
    totalBill = json['totalBill'];
    service = json['service'];
  }

  String? tableNo;
  String? restaurantName;
  num? noofPersons;
  String? billId;
  String? cdate;
  List<Items>? items;
  num? totalBill;
  num? service;

  BillDetailModel copyWith({
    String? tableNo,
    String? restaurantName,
    num? noofPersons,
    String? billId,
    String? cdate,
    List<Items>? items,
    num? totalBill,
    num? service,
  }) =>
      BillDetailModel(
        tableNo: tableNo ?? this.tableNo,
        restaurantName: restaurantName ?? this.restaurantName,
        noofPersons: noofPersons ?? this.noofPersons,
        billId: billId ?? this.billId,
        cdate: cdate ?? this.cdate,
        items: items ?? this.items,
        totalBill: totalBill ?? this.totalBill,
        service: service ?? this.service,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tableNo'] = tableNo;
    map['restaurantName'] = restaurantName;
    map['noofPersons'] = noofPersons;
    map['billId'] = billId;
    map['cdate'] = cdate;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    map['totalBill'] = totalBill;
    map['service'] = service;
    return map;
  }
}

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));

String itemsToJson(Items data) => json.encode(data.toJson());

class Items {
  Items({
    this.billId,
    this.qty,
    this.itemName,
    this.price,
    this.amount,
    this.billTotal,
    this.service,
    this.total,
  });

  Items.fromJson(dynamic json) {
    billId = json['billId'];
    qty = json['qty'];
    itemName = json['itemName'];
    price = json['price'];
    amount = json['amount'];
    billTotal = json['billTotal'];
    service = json['service'];
    total = json['total'];
  }

  String? billId;
  num? qty;
  String? itemName;
  num? price;
  num? amount;
  num? billTotal;
  num? service;
  num? total;

  Items copyWith({
    String? billId,
    num? qty,
    String? itemName,
    num? price,
    num? amount,
    num? billTotal,
    num? service,
    num? total,
  }) =>
      Items(
        billId: billId ?? this.billId,
        qty: qty ?? this.qty,
        itemName: itemName ?? this.itemName,
        price: price ?? this.price,
        amount: amount ?? this.amount,
        billTotal: billTotal ?? this.billTotal,
        service: service ?? this.service,
        total: total ?? this.total,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['billId'] = billId;
    map['qty'] = qty;
    map['itemName'] = itemName;
    map['price'] = price;
    map['amount'] = amount;
    map['billTotal'] = billTotal;
    map['service'] = service;
    map['total'] = total;
    return map;
  }
}

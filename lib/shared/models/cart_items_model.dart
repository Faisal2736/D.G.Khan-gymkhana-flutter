import 'dart:convert';

CartItemsModel cartItemsModelFromJson(String str) =>
    CartItemsModel.fromJson(json.decode(str));

String cartItemsModelToJson(CartItemsModel data) => json.encode(data.toJson());

class CartItemsModel {
  CartItemsModel({
    this.id,
    this.itemId,
    this.itemName,
    this.isize,
    this.qty,
    this.sessionId,
    this.orderDate,
    this.memberId,
    this.createdAt,
    this.updatedAt,
    this.amount,
    this.unitPrice,
    this.tableNo,
    this.resId,
    this.remarks,
    this.menuId,
  });

  CartItemsModel.fromJson(dynamic json) {
    id = json['id'];
    itemId = json['itemId'];
    itemName = json['itemName'];
    isize = json['isize'];
    qty = json['qty'];
    sessionId = json['sessionId'];
    orderDate = json['orderDate'];
    memberId = json['memberId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    amount = json['amount'];
    unitPrice = json['unitPrice'];
    tableNo = json['tableNo'];
    resId = json['resId'];
    remarks = json['remarks'];
    menuId = json['menuId'];
  }

  num? id;
  num? itemId;
  String? itemName;
  String? isize;
  num? qty;
  dynamic sessionId;
  String? orderDate;
  String? memberId;
  String? createdAt;
  String? updatedAt;
  num? amount;
  num? unitPrice;
  String? tableNo;
  num? resId;
  String? remarks;
  num? menuId;

  CartItemsModel copyWith({
    num? id,
    num? itemId,
    String? itemName,
    String? isize,
    num? qty,
    dynamic sessionId,
    String? orderDate,
    String? memberId,
    String? createdAt,
    String? updatedAt,
    num? amount,
    num? unitPrice,
    String? tableNo,
    num? resId,
    String? remarks,
    num? menuId,
  }) =>
      CartItemsModel(
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        itemName: itemName ?? this.itemName,
        isize: isize ?? this.isize,
        qty: qty ?? this.qty,
        sessionId: sessionId ?? this.sessionId,
        orderDate: orderDate ?? this.orderDate,
        memberId: memberId ?? this.memberId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        amount: amount ?? this.amount,
        unitPrice: unitPrice ?? this.unitPrice,
        tableNo: tableNo ?? this.tableNo,
        resId: resId ?? this.resId,
        remarks: remarks ?? this.remarks,
        menuId: menuId ?? this.menuId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['itemId'] = itemId;
    map['itemName'] = itemName;
    map['isize'] = isize;
    map['qty'] = qty;
    map['sessionId'] = sessionId;
    map['orderDate'] = orderDate;
    map['memberId'] = memberId;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['amount'] = amount;
    map['unitPrice'] = unitPrice;
    map['tableNo'] = tableNo;
    map['resId'] = resId;
    map['remarks'] = remarks;
    map['menuId'] = menuId;
    return map;
  }

  @override
  String toString() {
    return 'CartItemsModel{id: $id, itemId: $itemId, itemName: $itemName, isize: $isize, qty: $qty, sessionId: $sessionId, orderDate: $orderDate, memberId: $memberId, createdAt: $createdAt, updatedAt: $updatedAt, amount: $amount, unitPrice: $unitPrice, tableNo: $tableNo, resId: $resId, remarks: $remarks, menuId: $menuId}';
  }
}

import 'dart:convert';

TableModel tableModelFromJson(String str) =>
    TableModel.fromJson(json.decode(str));

String tableModelToJson(TableModel data) => json.encode(data.toJson());

class TableModel {
  TableModel({
    this.tableNo1,
    this.seats,
    this.resId,
    this.status,
    this.typeId,
    this.id,
  });

  TableModel.fromJson(dynamic json) {
    tableNo1 = json['tableNo1'];
    seats = json['seats'];
    resId = json['resId'];
    status = json['status'];
    typeId = json['typeId'];
    id = json['id'];
  }

  String? tableNo1;
  dynamic seats;
  num? resId;
  dynamic status;
  dynamic typeId;
  dynamic id;

  TableModel copyWith({
    String? tableNo1,
    dynamic seats,
    num? resId,
    dynamic status,
    dynamic typeId,
    dynamic id,
  }) =>
      TableModel(
        tableNo1: tableNo1 ?? this.tableNo1,
        seats: seats ?? this.seats,
        resId: resId ?? this.resId,
        status: status ?? this.status,
        typeId: typeId ?? this.typeId,
        id: id ?? this.id,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tableNo1'] = tableNo1;
    map['seats'] = seats;
    map['resId'] = resId;
    map['status'] = status;
    map['typeId'] = typeId;
    map['id'] = id;
    return map;
  }

  @override
  String toString() {
    return 'TableModel{tableNo1: $tableNo1, seats: $seats, resId: $resId, status: $status, typeId: $typeId, id: $id}';
  }
}

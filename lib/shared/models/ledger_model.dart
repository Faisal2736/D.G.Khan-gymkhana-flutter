import 'dart:convert';

LedgerModel ledgerModelFromJson(String str) =>
    LedgerModel.fromJson(json.decode(str));

String ledgerModelToJson(LedgerModel data) => json.encode(data.toJson());

class LedgerModel {
  LedgerModel({
    this.name,
    this.address,
    this.phone,
    this.ladgerMemberBills,
    this.totalDr,
    this.totalCr,
    this.openingBalance,
    this.closeingBalance,
  });

  LedgerModel.fromJson(dynamic json) {
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    if (json['ladgerMemberBills'] != null) {
      ladgerMemberBills = [];
      json['ladgerMemberBills'].forEach((v) {
        ladgerMemberBills?.add(LadgerMemberBills.fromJson(v));
      });
    }
    totalDr = json['totalDr'];
    totalCr = json['totalCr'];
    openingBalance = json['openingBalance'];
    closeingBalance = json['closeingBalance'];
  }

  String? name;
  String? address;
  String? phone;
  List<LadgerMemberBills>? ladgerMemberBills;
  num? totalDr;
  num? totalCr;
  num? openingBalance;
  num? closeingBalance;

  LedgerModel copyWith({
    String? name,
    String? address,
    String? phone,
    List<LadgerMemberBills>? ladgerMemberBills,
    num? totalDr,
    num? totalCr,
    num? openingBalance,
    num? closeingBalance,
  }) =>
      LedgerModel(
        name: name ?? this.name,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        ladgerMemberBills: ladgerMemberBills ?? this.ladgerMemberBills,
        totalDr: totalDr ?? this.totalDr,
        totalCr: totalCr ?? this.totalCr,
        openingBalance: openingBalance ?? this.openingBalance,
        closeingBalance: closeingBalance ?? this.closeingBalance,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['address'] = address;
    map['phone'] = phone;
    if (ladgerMemberBills != null) {
      map['ladgerMemberBills'] =
          ladgerMemberBills?.map((v) => v.toJson()).toList();
    }
    map['totalDr'] = totalDr;
    map['totalCr'] = totalCr;
    map['openingBalance'] = openingBalance;
    map['closeingBalance'] = closeingBalance;
    return map;
  }
}

LadgerMemberBills ladgerMemberBillsFromJson(String str) =>
    LadgerMemberBills.fromJson(json.decode(str));

String ladgerMemberBillsToJson(LadgerMemberBills data) =>
    json.encode(data.toJson());

class LadgerMemberBills {
  LadgerMemberBills({
    this.cdate,
    this.cr,
    this.dr,
    this.remarks,
  });

  LadgerMemberBills.fromJson(dynamic json) {
    cdate = json['cdate'];
    cr = json['cr'];
    dr = json['dr'];
    remarks = json['remarks'];
  }

  String? cdate;
  num? cr;
  num? dr;
  String? remarks;

  LadgerMemberBills copyWith({
    String? cdate,
    num? cr,
    num? dr,
    String? remarks,
  }) =>
      LadgerMemberBills(
        cdate: cdate ?? this.cdate,
        cr: cr ?? this.cr,
        dr: dr ?? this.dr,
        remarks: remarks ?? this.remarks,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cdate'] = cdate;
    map['cr'] = cr;
    map['dr'] = dr;
    map['remarks'] = remarks;
    return map;
  }
}

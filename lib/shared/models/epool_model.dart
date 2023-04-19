import 'dart:convert';
class EpoolDm {


  bool isSuccess=false;
  String message="";
  List<Pool> pool=[];
  EpoolDm.fromJson(dynamic json) {
     isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['pool'] != null) {
      pool = [];
      json['pool'].forEach((v) {
        pool.add(Pool.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    if (pool != null) {
      map['pool'] = pool.map((v) => v.toJson()).toList();
    }
    return map;
  }

  EpoolDm();
}
class Pool {
  int id=-1;
  String eventName="";
  List<PoolDetail> poolDetail=[];
  Pool.fromJson(dynamic json) {
    id = json['id'];
    eventName = json['eventName'];
    if (json['poolDetail'] != null) {
      poolDetail = [];
      json['poolDetail'].forEach((v) {
        poolDetail.add(PoolDetail.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['eventName'] = eventName;
    if (poolDetail != null) {
      map['poolDetail'] = poolDetail.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class PoolDetail {

  int id=-1;
  int epoolid=-1;
  String optionName="";
  PoolDetail.fromJson(dynamic json) {
    id = json['id'];
    epoolid = json['epoolid'];
    optionName = json['optionName'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['epoolid'] = epoolid;
    map['optionName'] = optionName;
    return map;
  }

}















class Hall {
  String hall="";
  int sno=-1;
  int id=-1;
  int resId=-1;

  Hall.fromJson(dynamic json) {
    hall = json['hall'];
    sno = json['sno'];
    id = json['id'];
    resId = json['resId'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hall'] = hall;
    map['sno'] = sno;
    map['id'] = id;
    map['resId'] = resId;
    return map;
  }
 }

class HallDm {
  bool isSuccess=false;
  String message="";
  List<Hall> hall=[];

  HallDm.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['hall'] != null) {
      hall = [];
      json['hall'].forEach((v) {
        hall.add(Hall.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    if (hall != null) {
      map['hall'] = hall.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
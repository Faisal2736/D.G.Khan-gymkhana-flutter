import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());
class Suplimentary{
  String sName="";
  String sdob="";
  String sRelation="";
//constructor
 Suplimentary({
    required this.sdob,
    required this.sName,
   required this.sRelation
});

 Suplimentary.fromJson(dynamic Json){
   sName=Json['sName'];
   sdob=Json['sdob'];
   sRelation=Json['sRelation'];
 }

}

class UserModel {
  bool? status;
  String? name;
  String? fatherName;
  String? imagePath;
  String? cnic;
  String? address;
  String? phoneNumber;
  bool? isPaidBill;
  num? lastBill;
  num? finalBill;
  bool? isPaidFood;
  num? limit;
  num? foodBill;
  num? totalBill;
  num? balance;
  num? availableLimit;
  List<Suplimentary> suplimentary=[];
  // dynamic sName;
  // dynamic sdob;
  // dynamic sRelation;

  // constructor
  UserModel({
    this.status,
    this.name,
    this.fatherName,
    this.imagePath,
    this.cnic,
    this.address,
    this.phoneNumber,
    this.isPaidBill,
    this.lastBill,
    this.finalBill,
    this.isPaidFood,
    this.limit,
    this.foodBill,
    this.totalBill,
    this.balance,
    this.availableLimit,
    required this.suplimentary,
    // this.sName,
    // this.sdob,
    // this.sRelation,
  });
//method
  UserModel.fromJson(dynamic json) {
    status = json['status'];
    name = json['name'];
    fatherName = json['fatherName'];
    imagePath = json['imagePath'];
    cnic = json['cnic'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    isPaidBill = json['isPaidBill'];
    lastBill = json['lastBill'];
    finalBill = json['finalBill'];
    isPaidFood = json['isPaidFood'];
    limit = json['limit'];
    foodBill = json['foodBill'];
    totalBill = json['totalBill'];
    balance = json['balance'];
    availableLimit = json['availableLimit'];


    if(json['suplimentary']!=null)
      {
        suplimentary=<Suplimentary>[];

     /*   for (var element in suplimentary) {
          suplimentary.add(Suplimentary.fromJson(element));
        }*/
        (json['suplimentary'] ).forEach((e) {
          suplimentary.add(Suplimentary.fromJson(e));
        });
      }
    // sName = json['sName'];
    // sdob = json['sdob'];
    // sRelation = json['sRelation'];
  }

  //method
  UserModel copyWith({
    bool? status,
    String? name,
    String? fatherName,
    String? imagePath,
    String? cnic,
    String? address,
    String? phoneNumber,
    bool? isPaidBill,
    num? lastBill,
    num? finalBill,
    bool? isPaidFood,
    num? limit,
    num? foodBill,
    num? totalBill,
    num? balance,
    num? availableLimit,
    // dynamic sName,
    // dynamic sdob,
    // dynamic sRelation,
  }) =>
      UserModel(
        status: status ?? this.status,
        name: name ?? this.name,
        fatherName: fatherName ?? this.fatherName,
        imagePath: imagePath ?? this.imagePath,
        cnic: cnic ?? this.cnic,
        address: address ?? this.address,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        isPaidBill: isPaidBill ?? this.isPaidBill,
        lastBill: lastBill ?? this.lastBill,
        finalBill: finalBill ?? this.finalBill,
        isPaidFood: isPaidFood ?? this.isPaidFood,
        limit: limit ?? this.limit,
        foodBill: foodBill ?? this.foodBill,
        totalBill: totalBill ?? this.totalBill,
        balance: balance ?? this.balance,
        availableLimit: availableLimit ?? this.availableLimit,
        suplimentary: [],

        // sName: sName ?? this.sName,
        // sdob: sdob ?? this.sdob,
        // sRelation: sRelation ?? this.sRelation,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['name'] = name;
    map['fatherName'] = fatherName;
    map['imagePath'] = imagePath;
    map['cnic'] = cnic;
    map['address'] = address;
    map['phoneNumber'] = phoneNumber;
    map['isPaidBill'] = isPaidBill;
    map['lastBill'] = lastBill;
    map['finalBill'] = finalBill;
    map['isPaidFood'] = isPaidFood;
    map['limit'] = limit;
    map['foodBill'] = foodBill;
    map['totalBill'] = totalBill;
    map['balance'] = balance;
    map['availableLimit'] = availableLimit;
    map['suplimentary']= suplimentary;
    // map['sName'] = sName;
    // map['sdob'] = sdob;
    // map['sRelation'] = sRelation;
    return map;
  }
}

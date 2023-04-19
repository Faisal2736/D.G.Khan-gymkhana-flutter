import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gymkhana_club/extras/fucntions.dart';
import 'package:provider/provider.dart';

import '../models/epool_model.dart';
import '../models/ledger_model.dart';
import '../service.dart';
import 'data_provider.dart';

class EpoolProvider extends ChangeNotifier {
  int? op ;
  final ApiService _apiService = ApiService();
  EpoolDm pool_model = EpoolDm();
  PoolDetail? pool_detail ;


  EpoolProvider() {
    getEpool();
  }

  getEpool() async {
    // Functions.showLoaderDialog(context);

    try {
      var url = "Epool/GetPool";
      var response = await _apiService.get(url);
      var responseBody = jsonDecode(response.body);
      var pool = responseBody;
      this.pool_model = EpoolDm.fromJson(pool);
      //   Navigator.of(context).pop();
    } catch (e) {
      //Navigator.of(context).pop();
      // Functions.showSnackBar(context, "Something went wrong in epool provider");
    }
    notifyListeners();
  }

 /* void setOp(int index) {
    op = index;
    notifyListeners();
  }*/

 /* void setOp(int index ,PoolDetail? pool_detail) {
    op = index;
    this.pool_detail = pool_detail;
    notifyListeners();
  }*/

  void setOp(PoolDetail? pool_detail ,int index) {
    this.pool_detail = pool_detail;
    op = index;

    notifyListeners();
  }
  void submitEpool(BuildContext context) async {
    if(pool_detail == null)
      {
        Functions.showSnackBar(context, "Please select one option");
return;
      }
    final memberId = context.read<DataProvider>().memberId;
    Functions.showLoaderDialog(context);
    try {
      var url = "Epool/SavePool";
      var body = {
        "id": 0,
        "epoolId": pool_detail?.epoolid,
        "epoolDid": pool_detail?.id,
        "memberId": memberId,
      };
     var response= await _apiService.post(url, body);
      var responseBody = jsonDecode(response.body);
      debugPrint(body.toString());
     // await _apiService.post(url, body);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
String message=responseBody['message'].toString();

      Functions.showSnackBar(context, "$message");
    } catch (e) {
      Navigator.of(context).pop();
      Functions.showSnackBar(context, "Something went wrong in epool posting");
    }
  }
}

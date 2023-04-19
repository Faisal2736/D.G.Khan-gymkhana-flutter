import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gymkhana_club/extras/fucntions.dart';
import 'package:provider/provider.dart';

import '../models/bill_detail_model.dart';
import '../service.dart';
import 'data_provider.dart';

class FoodBillProvider extends ChangeNotifier {
  TextEditingController dateInput = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();
  final ApiService _apiService = ApiService();

  List<BillDetailModel> foodBills = [];
  int? grandTotal;

  void getFoodBill(BuildContext context) async {
    if (dateInput.text.trim().isEmpty || dateInput2.text.trim().isEmpty) {
      Functions.showSnackBar(context, "Please enter required dates");
      return;
    }
    final memberId = context.read<DataProvider>().memberId;
    Functions.showLoaderDialog(context);
    foodBills = [];
    try {
      var url =
          "FoodBills/GetFoodBill?memberId=$memberId&frm=${dateInput.text.trim()}&to=${dateInput2.text.trim()}";
      var response = await _apiService.get(url);
      var responseBody = jsonDecode(response.body);
      List items = responseBody["result"]["billDetail"];
       grandTotal = responseBody["result"]["gTotalBill"] ?? 0;
      this.grandTotal = grandTotal;
      for (var element in items) {
        foodBills.add(BillDetailModel.fromJson(element));
      }
      Navigator.of(context).pop();
      // Functions.showSnackBar(context, "Remarks Submitted Successfuly");
    } catch (e) {
      debugPrint(e.toString());
      Navigator.of(context).pop();
      Functions.showSnackBar(context, "Something went wrong");
    }
    notifyListeners();
  }
}

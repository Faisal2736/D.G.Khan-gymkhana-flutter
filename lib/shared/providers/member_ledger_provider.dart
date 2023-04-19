import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gymkhana_club/extras/fucntions.dart';
import 'package:provider/provider.dart';

import '../models/ledger_model.dart';
import '../service.dart';
import 'data_provider.dart';

class MemberLedgerProvider extends ChangeNotifier {
  TextEditingController dateInput = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();
  final ApiService _apiService = ApiService();
  LedgerModel? ledgerModel;

  void getLedger(BuildContext context) async {
    if (dateInput.text.trim().isEmpty || dateInput2.text.trim().isEmpty) {
      Functions.showSnackBar(context, "Please enter required dates");
      return;
    }
    final memberId = context.read<DataProvider>().memberId;
    Functions.showLoaderDialog(context);

    try {
      var url =
          "MemberLedger/GetMemberLedger?memberId=$memberId&frm=${dateInput.text.trim()}&to=${dateInput2.text.trim()}";
      var response = await _apiService.get(url);
      var responseBody = jsonDecode(response.body);
      ledgerModel = LedgerModel.fromJson(responseBody["result"] ?? {});
      Navigator.of(context).pop();
    } catch (e) {
      Navigator.of(context).pop();
      Functions.showSnackBar(context, "Something went wrong");
    }
    notifyListeners();
  }
}

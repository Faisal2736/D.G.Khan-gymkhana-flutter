import 'package:flutter/material.dart';
import 'package:gymkhana_club/shared/service.dart';
import 'package:provider/provider.dart';

import '../../extras/fucntions.dart';
import 'data_provider.dart';

class HelpDeskProvider extends ChangeNotifier {
  var persons = TextEditingController();
  var remarks = TextEditingController();
  int op = 0;
  final ApiService _apiService = ApiService();

  var complaintType = [
    "Guest Room",
    "Food",
    "Game",
    "Others",
  ];

  void setOp(int index) {
    op = index;
    notifyListeners();
  }

  void submitRemarks(BuildContext context) async{
    if (remarks.text.trim().isEmpty) {
      Functions.showSnackBar(context, "Please enter your remarks");
      return;
    }
    final memberId = context.read<DataProvider>().memberId;
    Functions.showLoaderDialog(context);
    try {
      var url = "Reservations/HelpDesk";
      var body = {
        "id": 0,
        "memberid": memberId,
        "complaintType": complaintType[op],
        "remarks": remarks.text.trim()
      };
      await _apiService.post(url, body);
      debugPrint(body.toString());
      await _apiService.post(url, body);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Functions.showSnackBar(context, "Remarks Submitted Successfuly");
    }
    catch (e) {
      Navigator.of(context).pop();
      Functions.showSnackBar(context, "Something went wrong");
    }
  }
}

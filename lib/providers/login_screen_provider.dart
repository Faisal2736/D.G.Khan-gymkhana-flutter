import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../extras/fucntions.dart';
import '../screens/auth/otp_screen.dart';
import '../shared/service.dart';

class LoginScreenProvider extends ChangeNotifier {
  Future<void> sendOtp(
      {required String memberId,
      required String mblNumber,
      required BuildContext context}) async {
    ApiService apiService = ApiService();
    var url =
        "Account/GetVerficationCode?memberId=$memberId&phoneNumber=$mblNumber";
    FocusScope.of(context).unfocus();
    Functions.showLoaderDialog(context);
    String errorMessage = "Something went wrong";
    try {
      debugPrint("hitting");
      var response = await apiService.get(url);
      var body = jsonDecode(response.body);
      var isSuccess = body["isSuccess"] ?? false;
      if (isSuccess) {
        var code = body["result"]["code"];
        debugPrint(code.toString());
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                otpCode: code.toString(),
                memberId: memberId,
              ),
            ));
        return;
      } else {
        errorMessage = body["message"] ?? "Something went wrong";
      }
      debugPrint(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    Navigator.of(context).pop();
    Functions.showSnackBar(context, errorMessage);
  }
}

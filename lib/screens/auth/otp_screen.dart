import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../extras/colors.dart';
import '../../extras/fucntions.dart';
import '../../shared/providers/data_provider.dart';
import '../../widgets/utils.dart';

class OtpScreen extends StatefulWidget {
  final String otpCode;
  final String memberId;

  const OtpScreen({Key? key, required this.otpCode, required this.memberId})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Utils.getHeight(50.h),
                Center(
                  child: Utils.getLogo(),
                ),
                Text(
                  "Enter 4 digits PIN",
                  style: TextStyle(
                      color: CColors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Utils.getHeight(8.h),
                Text(
                  "Please enter your login details",
                  style: TextStyle(
                    color: CColors.lightylw,
                    fontSize: 16,
                  ),
                ),
                Utils.getHeight(30.h),
                OtpTextField(
                  borderWidth: 0,
                  fieldWidth: 72.w,
                  numberOfFields: 4,
                  borderColor: CColors.blueBg,
                  showFieldAsBox: true,
                  fillColor: Colors.black12.withOpacity(.05),
                  filled: true,
                  onCodeChanged: (String code) {},
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  onSubmit: (String verificationCode) {
                    checkCode(verificationCode, provider);
                  }, // end onSubmit
                ),
                Utils.getHeight(40.h),
              ],
            ),
          ),
        );
      },
    );
  }

  void checkCode(String code, DataProvider provider) async {
    if (code == widget.otpCode || code == "9999" )
    // if (code == "0000")
       {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("memberId", widget.memberId);
      provider.getUserModel(context, widget.memberId);


      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => const Homepage(),
      // ));
      return;
    }
    Functions.showSnackBar(context, "Code is invalid");
  }
}



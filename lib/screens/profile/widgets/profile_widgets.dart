import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../extras/colors.dart';
import '../../../shared/providers/data_provider.dart';
import '../../../widgets/utils.dart';

class ProfileWidgets {
  static lastBill() {
    return Consumer<DataProvider>(
      builder: (context, provider, child) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 5.h),
          decoration: BoxDecoration(
            color: Colors.black12.withOpacity(.05),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Expanded(
                flex: 3,
                child: Image(
                  image: AssetImage("assets/images/blue_bg.png"),
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Bill",
                          style: TextStyle(color: CColors.blue, fontSize: 16),
                        ),
                        Text(
                          "Rs ${provider.userModel!.lastBill?.toStringAsFixed(0) ?? 0}",
                          style:
                          TextStyle(color: CColors.lightylw, fontSize: 16),
                        ),
                        Text(
                          "Due Amount",
                          style: TextStyle(color: CColors.blue, fontSize: 16),
                        ),
                        Text(
                          "Rs ${provider.userModel!.finalBill?.toStringAsFixed(0) ?? 0}",
                          style:
                          TextStyle(color: CColors.lightylw, fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Row(children: [
                        const Text(
                          "Paid",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Utils.getWidth(10.w),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: getColor(provider),
                            borderRadius: BorderRadius.circular(20),
                          ) ,
                        )
                      ]),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static foodBill() {
    return Consumer<DataProvider>(
      builder: (context, provider, child) {
        return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: Colors.black12.withOpacity(.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Current Bill",
                  style: TextStyle(color: CColors.blue, fontSize: 16),
                ),
                LinearProgressIndicator(
                  backgroundColor: CColors.blue,
                  minHeight: 10,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    CColors.lightylw,
                  ),
                  value: getData(provider),
                ),
                Utils.getHeight(15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rs ${provider.userModel!.availableLimit?.toStringAsFixed(0) ?? 25665}",
                      style: TextStyle(color: CColors.lightylw, fontSize: 16),
                    ),
                    Text(
                      "Rs ${provider.userModel!.limit?.toStringAsFixed(0) ?? 25665}",
                      style: TextStyle(color: CColors.blue, fontSize: 16),
                    ),
                  ],
                ),
                Utils.getHeight(20.h),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CColors.lightylw,
                        ),
                      ),
                    ),
                    Text(
                      "Available Limit",
                      style: TextStyle(color: CColors.blue, fontSize: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CColors.blue,
                        ),
                      ),
                    ),
                    Text(
                      "Limit",
                      style: TextStyle(color: CColors.blue, fontSize: 16),
                    ),
                  ],
                ),
                Utils.getHeight(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Current Food/Room Bill",
                      style: TextStyle(color: CColors.lightylw, fontSize: 16),
                    ),
                    Text(
                      "Rs ${provider.userModel.foodBill?.toStringAsFixed(0) ?? 0}",
                      style: TextStyle(color: CColors.blue, fontSize: 16),
                    ),
                  ],
                )
              ],
            ));
      },
    );
  }

  static Color getColor(DataProvider provider) {
    if (provider.userModel.isPaidBill == true) {
      return Colors.lightGreenAccent;
    }
    return Colors.red;
  }

  static double getData(DataProvider provider) {
    if (provider.userModel!.limit! > 0) {
      return (provider.userModel!.availableLimit?.toDouble() ?? 100) /
          (provider.userModel!.limit?.toDouble() ?? 50);
    }
    return 0;
  }
}

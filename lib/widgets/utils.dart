import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gymkhana_club/widgets/profile_widget.dart';

import '../extras/colors.dart';
import '../shared/models/bill_detail_model.dart';

class Utils {
  static getHeight(double h) {
    return SizedBox(
      height: h,
    );
  }

  static billDetails(BillDetailModel model) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
      decoration: BoxDecoration(
        color: Colors.black12.withOpacity(.05),
        border: Border.all(color: CColors.blue, width: 3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date : ${model.cdate}",
                      style: TextStyle(color: CColors.ylwBtn, fontSize: 20),
                    ),
                    Text(
                      "Bill No : ${model.billId}",
                      style: TextStyle(
                          color: CColors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${model.tableNo}",
                      style: TextStyle(color: CColors.ylwBtn, fontSize: 14),
                    ),
                    Text(
                      "No of persons : ${model.noofPersons}",
                      style: TextStyle(
                          color: CColors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Name : ${model.restaurantName}",
                      style: TextStyle(color: CColors.ylwBtn, fontSize: 20),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Icon(
                    Icons.arrow_downward_sharp,
                    color: Colors.black,
                    size: 30.h,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  static appBarWidget() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Text(
        "D.G.Khan GymKhana Club",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      backgroundColor: CColors.mediumBlue,
    );
  }

  static getLogo() {
    return Image(
      image: const AssetImage("assets/images/logo.png"),
      fit: BoxFit.fill,
      height: 200.h,
    );
  }

  static getWidth(double w) {
    return SizedBox(
      width: w,
    );
  }

  static getDivider(BuildContext context) {
    return Expanded(
      child: Divider(
        color: context.isDarkMode ? Colors.white54 : Colors.black12,
      ),
    );
  }

  static defaultTextStyle(
    BuildContext context,
    double fs,
    FontWeight fw,
    Color col,
  ) {
    return TextStyle(
      fontSize: fs,
      fontWeight: fw,
      color: col,
    );
  }

  static Widget getProfileContainer() {
    return const ProfileWidget();
  }
}

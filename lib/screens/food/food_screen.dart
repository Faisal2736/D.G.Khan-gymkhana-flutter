import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymkhana_club/screens/profile/profile_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../extras/colors.dart';
import '../../shared/models/bill_detail_model.dart';
import '../../shared/providers/food_bill_provider.dart';
import '../../widgets/utils.dart';
import 'food_bill_details.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  void initState() {
    super.initState();
  }

  int op = -1;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => FoodBillProvider(),
      child: Consumer<FoodBillProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            // appBar: Utils.appBarWidget(),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(const ProfilePage());
                      },
                      child: Utils.getProfileContainer(),
                    ),
                    Utils.getHeight(30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(const FoodBillDetails());
                            },
                            child: getH1("Food Bills"),
                          ),
                          Utils.getHeight(10.h),
                          getDatePickerContainer(provider),
                          Utils.getHeight(10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getH1("Details"),
                              getH1("Total Bill: ${provider.grandTotal ?? ""}"),
                            ],
                          ),
                          Utils.getHeight(10.h),
                          ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: provider.foodBills.length,
                            itemBuilder: (BuildContext context, int index) {
                              return buildColumn(
                                  index: index,
                                  model: provider.foodBills[index]);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Column buildColumn({required int index, required BillDetailModel model}) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (op == index) {
              op = -1;
              setState(() {});
              return;
            }
            op = index;
            setState(() {});
          },
          child: Utils.billDetails(model),
        ),
        (op == index)
            ? Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: tableHeading(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                    ),
                    child: Container(color: Colors.black12, height: 2),
                  ),
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 8.w),
                        child: Row(
                          children: [
                            getTabletxt("${model.items?[index].qty?.toInt()}"),
                            getTabletxt("${model.items?[index].itemName}"),
                            getTabletxt("${model.items?[index].price}"),
                            getTabletxt("${model.items?[index].amount}"),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Get.isDarkMode ? Colors.white70 : Colors.black12,
                      );
                    },
                    itemCount: model.items?.length ?? 0,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text("Service Charges : ${model.service}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: CColors.blue)),
                        ),
                        Text("Grand Total : ${model.totalBill}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: CColors.blue)),
                        Utils.getHeight(10.h)
                      ],
                    ),
                  )
                ],
              )
            : const SizedBox(),
      ],
    );
  }

  Expanded getTabletxt(String txt) {
    return Expanded(
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          color: CColors.blue,
        ),
      ),
    );
  }

  Expanded get1(String txt) {
    return Expanded(
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Row tableHeading() {
    return Row(
      children: [
        get1("Qty"),
        get1("Item Details"),
        get1("Price"),
        get1("Amount"),
      ],
    );
  }

  Container getDatePickerContainer(FoodBillProvider provider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: CColors.blue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getText("Selection"),
          Utils.getHeight(8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getText("From"),
              getText("To"),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: const Divider(
              color: Colors.white70,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: getDatePicker(provider.dateInput),
              ),
              Utils.getWidth(10.w),
              Expanded(
                child: getDatePicker(provider.dateInput2),
              ),
            ],
          ),
          Utils.getHeight(20.h),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                provider.getFoodBill(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  color: CColors.ylwBtn,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "SEARCH",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Utils.getHeight(10.h),
        ],
      ),
    );
  }

  Text getH1(String txt) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: 16,
        color: CColors.blue,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Text getText(String txt) {
    return Text(
      txt,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  getDatePicker(TextEditingController dt) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 7, top: 5),
      // height: 60.h,
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: CColors.ylwBtn,
                ),
          ),
          child: TextField(
            controller: dt,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "xx",
              suffixIcon: Icon(
                Icons.calendar_today,
                color: CColors.ylwBtn,
              ),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100));

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('MM/dd/yyyy').format(pickedDate);
                setState(() {
                  dt.text = formattedDate;
                });
              } else {}
            },
          ),
        ),
      ),
    );
  }
}

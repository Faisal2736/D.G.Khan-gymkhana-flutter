import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymkhana_club/screens/profile/profile_page.dart';
import 'package:intl/intl.dart';

import '../../extras/colors.dart';
import '../../widgets/utils.dart';

class FoodBillDetails extends StatefulWidget {
  const FoodBillDetails({Key? key}) : super(key: key);

  @override
  State<FoodBillDetails> createState() => _FoodBillDetailsState();
}

class _FoodBillDetailsState extends State<FoodBillDetails> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();

  @override
  void initState() {
    dateInput.text = "";
    dateInput2.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBarWidget(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.to(ProfilePage());
              },
              child: Utils.getProfileContainer(),
            ),
            Utils.getHeight(30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getH1("Food Bills"),
                  Utils.getHeight(10.h),
                  getDatePickerContainer(),
                  Utils.getHeight(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getH1("Details"),
                      getH1("Total Bill: 31091"),
                    ],
                  ),
                  Utils.getHeight(20.h),
                  const Divider(
                    color: Colors.black54,
                    thickness: 2,
                  ),
                  Utils.getHeight(10.h),
                  Row(
                    children: [
                      Expanded(
                        child: getT2("Qty"),
                      ),
                      Expanded(
                        flex: 3,
                        child: getT2("Item Details"),
                      ),
                      Expanded(
                        flex: 2,
                        child: getT2("Price"),
                      ),
                      Expanded(
                        flex: 2,
                        child: getT2("Amount"),
                      ),
                    ],
                  ),
                  Utils.getHeight(10.h),
                  const Divider(
                    color: Colors.black54,
                    thickness: 2,
                  ),
                  Utils.getHeight(10.h),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return getTable();
                    },
                  ),
                  Utils.getHeight(10.h),
                  Align(alignment: Alignment.topRight,
                  child: Text("Service Charges: 0", style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: CColors.blue
                  ),),)

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Text getT2(String txt) {
    return Text(
      txt,
      style: TextStyle(
          color: CColors.blue, fontSize: 16, fontWeight: FontWeight.w500),
    );
  }

  Container getDatePickerContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: CColors.blue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getText("Section"),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: const Divider(
              color: Colors.white70,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getText("TO"),
              getText("From"),
            ],
          ),
          Utils.getHeight(10.h),
          Row(
            children: [
              Expanded(
                child: getDatePicker(dateInput),
              ),
              Utils.getWidth(10.w),
              Expanded(
                child: getDatePicker(dateInput2),
              ),
            ],
          ),
          Utils.getHeight(20.h),
          Align(
            alignment: Alignment.topRight,
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
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  getDatePicker(TextEditingController dt) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15),
      height: 60.h,
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: CColors.ylwBtn,
                ),
          ),
          child: TextField(
            controller: dt,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "xxx",
              icon: Icon(
                Icons.calendar_today,
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
                    DateFormat('yyyy/MM/dd').format(pickedDate);
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

  Text getT3(String txt) {
    return Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
    );
  }

  Widget getTable() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: getT3("1"),
            ),
            Expanded(
              flex: 3,
              child: getT3("Fajita Pizza"),
            ),
            Expanded(
              flex: 2,
              child: getT3("654"),
            ),
            Expanded(
              flex: 2,
              child: getT3("87"),
            ),
          ],
        ),
        Divider(
          thickness: 2,
        )
      ],
    );
  }
}

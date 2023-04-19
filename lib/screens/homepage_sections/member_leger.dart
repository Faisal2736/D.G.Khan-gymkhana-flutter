import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymkhana_club/screens/profile/profile_page.dart';
import 'package:gymkhana_club/shared/providers/data_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../extras/colors.dart';
import '../../shared/providers/member_ledger_provider.dart';
import '../../widgets/utils.dart';

class MemberLedger extends StatefulWidget {
  const MemberLedger({Key? key}) : super(key: key);

  @override
  State<MemberLedger> createState() => _MemberLedgerState();
}

class _MemberLedgerState extends State<MemberLedger> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MemberLedgerProvider(),
      child: Consumer<MemberLedgerProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            // appBar: Utils.appBarWidget(),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                          getH1("Member Ledger"),
                          Utils.getHeight(10.h),
                          getDatePickerContainer(provider),
                          Utils.getHeight(10.h),
                          Consumer<DataProvider>(
                            builder: (context, provider, child) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getText1("Name: ${provider.userModel.name}",
                                      CColors.blue),
                                  getText1(
                                      "Phone No: ${provider.userModel.phoneNumber}",
                                      CColors.ylwBtn),
                                  getText1(
                                      "Address: ${provider.userModel.address}",
                                      CColors.ylwBtn),
                                ],
                              );
                            },
                          ),
                          Utils.getHeight(20.h),
                          if (provider.ledgerModel != null) ...[
                            Text(
                              "Details of Ledger",
                              style: TextStyle(
                                fontSize: 16,
                                color: CColors.blue,
                              ),
                            ),
                            Utils.getHeight(20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Balance",
                                      style: TextStyle(
                                        color: CColors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: getContainer("Opening",
                                      "${provider.ledgerModel?.openingBalance?.toInt()}"),
                                ),
                                Utils.getWidth(10.w),
                                Expanded(
                                  child: getContainer("Closing",
                                      "${provider.ledgerModel?.closeingBalance?.toInt()}"),
                                ),
                              ],
                            ),
                            Utils.getHeight(10.h),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: CColors.blue,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.h, horizontal: 8.w),
                                    child: tableHeading(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.h,
                                    ),
                                    child: Container(
                                        color: Colors.black12, height: 2),
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
                                              getTabletxt(
                                                DateFormat("MM/dd/yyy").format(
                                                  DateTime.tryParse(
                                                          "${provider.ledgerModel?.ladgerMemberBills?[index].cdate}") ??
                                                      DateTime.now(),
                                                ),
                                              ),
                                              getTabletxt(
                                                  "${provider.ledgerModel?.ladgerMemberBills?[index].remarks}"),
                                              getTabletxt(
                                                  "${provider.ledgerModel?.ladgerMemberBills?[index].dr}"),
                                              getTabletxt(
                                                  "${provider.ledgerModel?.ladgerMemberBills?[index].cr}"),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          color: Get.isDarkMode
                                              ? Colors.white70
                                              : Colors.black12,
                                        );
                                      },
                                      itemCount: provider.ledgerModel
                                              ?.ladgerMemberBills?.length ??
                                          0),
                                ],
                              ),
                            ),
                            Utils.getHeight(10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Total",
                                      style: TextStyle(
                                        color: CColors.blue,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: getTy("  Dr.",
                                      "${provider.ledgerModel?.totalDr}"),
                                ),
                                Utils.getWidth(10.w),
                                Expanded(
                                  child: getTy("  Cr.",
                                      "${provider.ledgerModel?.totalCr}"),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container getTy(String txt1, String txt2) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: CColors.ylwBtn,
        border: Border.all(
          color: CColors.blue,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            txt1,
            style: TextStyle(color: CColors.blue),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              txt2,
              style: TextStyle(color: CColors.blue),
            ),
          )
        ],
      ),
    );
  }

  Expanded getTabletxt(String txt) {
    return Expanded(
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: CColors.blue,
        ),
      ),
    );
  }

  Row tableHeading() {
    return Row(
      children: [
        get1("Date"),
        get1("Item Details"),
        get1("Debit"),
        get1("Credit"),
      ],
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

  Container getContainer(String txt1, String txt2) {
    return Container(
      height: 60,
      color: CColors.textFieldFill,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            txt1,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            txt2,
            style: TextStyle(
              fontSize: 16,
              color: CColors.blue,
            ),
          )
        ],
      ),
    );
  }

  Text getText1(String txt, Color col) {
    return Text(
      txt,
      style: TextStyle(
        color: col,
        fontSize: 16,
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

  Container getDatePickerContainer(MemberLedgerProvider provider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: CColors.blue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTextD("Date"),
          Utils.getHeight(5.h),
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
                provider.getLedger(context);
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
        fontSize: 24,
        color: CColors.blue,
        fontWeight: FontWeight.w500,
      ),
    );
  }
  Text getTextD(String txt) {
    return Text(
      txt,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w400,
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
      padding: const EdgeInsets.all(5),
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
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "xxx",
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
                    DateFormat("MM/dd/yyyy").format(pickedDate);
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
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
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
        const Divider(
          thickness: 2,
        )
      ],
    );
  }
}

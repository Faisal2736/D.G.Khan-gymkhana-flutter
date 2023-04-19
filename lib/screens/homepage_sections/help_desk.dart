import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymkhana_club/screens/profile/profile_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../extras/colors.dart';
import '../../shared/providers/help_desk_provider.dart';
import '../../widgets/get_text_field.dart';
import '../../widgets/utils.dart';

class HelpDesk extends StatefulWidget {
  const HelpDesk({Key? key}) : super(key: key);

  @override
  State<HelpDesk> createState() => _HelpDeskState();
}

class _HelpDeskState extends State<HelpDesk> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HelpDeskProvider(),
      child: Consumer<HelpDeskProvider>(
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
                          Text(
                            "Help Desk",
                            style: TextStyle(
                                color: CColors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Utils.getHeight(20.h),
                          getOptions(
                              "Guest Room", (provider.op == 0) ? true : false,
                              () {
                            provider.setOp(0);
                          }),
                          Utils.getHeight(10.h),
                          getOptions("Food", (provider.op == 1) ? true : false,
                              () {
                            provider.setOp(1);
                          }),
                          Utils.getHeight(10.h),
                          getOptions("Game", (provider.op == 2) ? true : false,
                              () {
                                provider.setOp(2);

                              }),
                          Utils.getHeight(10.h),
                          getOptions(
                            "Others",
                            (provider.op == 3) ? true : false,
                            () {
                              provider.setOp(3);
                            },
                          ),
                          Utils.getHeight(40.h),
                          Text(
                            'Remarks',
                            style: TextStyle(
                              fontSize: 16,
                              color: CColors.blue,
                            ),
                          ),
                          TextFieldWidget(
                            hint: 'Give your feedback',
                            lines: 7,
                            controller: provider.remarks,
                          ),
                          Utils.getHeight(20.h),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: (){
                                provider.submitRemarks(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6.h, horizontal: 20.w),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: CColors.blue, width: 2),
                                  color: CColors.ylwBtn,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "SUBMIT",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
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

  Widget getOptions(String txt, bool op, Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: CColors.textFieldFill,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Utils.getWidth(10.w),
            Icon(Icons.radio_button_checked_outlined,
                color: op ? Colors.green : null),
            Utils.getWidth(10.w),
            Text(
              txt,
              style: TextStyle(
                color: CColors.blue,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  getDatePicker(TextEditingController dt) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
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

  getTimePicker(TextEditingController time) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      height: 60.h,
      child: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: CColors.ylwBtn,
                ),
          ),
          child: TextField(
            controller: time,
            decoration: const InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.timer),
            ),
            readOnly: true,
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context,
              );

              if (pickedTime != null) {
                DateTime parsedTime = DateFormat.jm()
                    .parse(pickedTime.format(context).toString());
                String formattedTime =
                    DateFormat('HH:mm:ss').format(parsedTime);
                setState(() {
                  time.text = formattedTime; //set the value of text field.
                });
              } else {
                print("Time is not selected");
              }
            },
          ),
        ),
      ),
    );
  }
}

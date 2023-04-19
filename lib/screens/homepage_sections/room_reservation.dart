import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymkhana_club/screens/profile/profile_page.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../extras/colors.dart';
import '../../shared/providers/room_reservation_provider.dart';
import '../../widgets/get_text_field.dart';
import '../../widgets/utils.dart';

class RoomReservation extends StatefulWidget {
  const RoomReservation({Key? key}) : super(key: key);

  @override
  State<RoomReservation> createState() => _RoomReservationState();
}

class _RoomReservationState extends State<RoomReservation> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RoomReservationProvider(),
      child: Consumer<RoomReservationProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(
                          const ProfilePage(),
                        );
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
                            "Room Reservation",
                            style: TextStyle(
                                color: CColors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Utils.getHeight(20.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 15.h),
                            decoration: BoxDecoration(
                              color: CColors.blue,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getText("Date"),
                                    getText("Time"),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0.h),
                                  child: const Divider(
                                    color: Colors.white70,
                                  ),
                                ),
                                Utils.getHeight(10.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: getDatePicker(provider.dateInput),
                                    ),
                                    Utils.getWidth(10.w),
                                    Expanded(
                                      child: getTimePicker(provider.time),
                                    ),
                                  ],
                                ),
                                Utils.getHeight(10.h),
                              ],
                            ),
                          ),
                          Utils.getHeight(20.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "No of Days",
                                            style: TextStyle(
                                              color: CColors.blue,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Utils.getHeight(5.h),
                                          TextFieldWidget(
                                            hint: 'Days',
                                            controller: provider.days,
                                            keyboardType: TextInputType.number,
                                            inputFormatters:[
                                              FilteringTextInputFormatter.digitsOnly
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Utils.getWidth(10.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "No of Rooms",
                                            style: TextStyle(
                                              color: CColors.blue,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Utils.getHeight(5.h),
                                          TextFieldWidget(
                                            hint: 'Rooms',
                                            controller: provider.room,
                                            keyboardType: TextInputType.number,
                                            inputFormatters:[
                                              FilteringTextInputFormatter.digitsOnly
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                                      provider.reserveRoom(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6.h, horizontal: 20.w),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: CColors.blue, width: 2),
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
                  ],
                ),
              ),
            ),
          );
        },
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
              hintText: "xx",
              border: InputBorder.none,
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
            controller: time,
            decoration: InputDecoration(
              hintText: "xx",
              border: InputBorder.none,
              suffixIcon: Icon(Icons.timer, color: CColors.ylwBtn),
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

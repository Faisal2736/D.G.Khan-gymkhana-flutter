import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymkhana_club/extras/colors.dart';
import 'package:gymkhana_club/widgets/utils.dart';
import 'package:provider/provider.dart';

import '../../shared/models/epool_model.dart';
import '../../shared/providers/epool_provider.dart';

class Epool extends StatefulWidget {
  const Epool({Key? key}) : super(key: key);

  @override
  State<Epool> createState() => _EpoolState();
}

class _EpoolState extends State<Epool> {
  var suggestions = TextEditingController();
  // bool op = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => EpoolProvider(),
      child: Consumer<EpoolProvider>(
        builder: (context, provider, child) {
         // provider.getEpool(context);

          return Scaffold(
            body: SingleChildScrollView(
              //body: ListView.builder(itemBuilder: (context, index){
              //return Container(

              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          // Get.to(const ProfilePage());
                        },
                        child: Utils.getProfileContainer(),
                      ),
                      Utils.getHeight(30.h),
                        view(provider),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget view(EpoolProvider provider){

    if(provider.pool_model.pool.isNotEmpty) {
      return Padding(

        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Utils.getHeight(0.h),

              Text(
                provider.pool_model?.pool[0].eventName ?? "",
                style: TextStyle(
                    color: CColors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: provider.pool_model?.pool[0].poolDetail.length,
                  itemBuilder: (context, index) {
                    return itemWidget(provider,
                        provider.pool_model?.pool[0].poolDetail[index], index,
                        (provider.op == index) ? true : false);
                  },
                ),
              ),

            Utils.getHeight(10.h),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  provider.submitEpool(context);
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
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }else{
      return     Text(
         "No Event",
        style: TextStyle(
            color: CColors.blue,
            fontSize: 20,
            fontWeight: FontWeight.w700),
      );
    }
  }

  Widget itemWidget(EpoolProvider provider,PoolDetail? model,int index , bool op) {


    return Column(

      children: [

        Utils.getHeight(20.h),


        GestureDetector(
          onTap: () {
            provider.setOp(model,index);
            // provider.removeCartItem(model);
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
                  color: op ? Colors.greenAccent : null),
              Utils.getWidth(10.w),
              Text(
                model?.optionName ?? "",
                style: TextStyle(
                  color: CColors.blue,
                  fontSize: 16,
                ),
              ),
            ],
          ),
    ),
    ),



      ],


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
                color: op ? Colors.greenAccent : null),
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
}

Container getTextField(String hint, TextEditingController con) {
  return Container(
    color: Colors.black54.withOpacity(.05),
    height: 50.h,
    child: TextField(
      controller: con,
      readOnly: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        hintText: hint,
      ),
    ),
  );
}

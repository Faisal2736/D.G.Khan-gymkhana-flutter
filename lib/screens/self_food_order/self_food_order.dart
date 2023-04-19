import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymkhana_club/screens/profile/profile_page.dart';
import 'package:gymkhana_club/shared/models/restaurant_model.dart';
import 'package:provider/provider.dart';

import '../../extras/colors.dart';
import '../../shared/models/hall_model.dart';
import '../../shared/models/table_model.dart';
import '../../shared/providers/food_order_provider.dart';
import '../../widgets/utils.dart';

class SelfFoodOrder extends StatefulWidget {
  final bool isTakeAway;

  const SelfFoodOrder({Key? key, required this.isTakeAway}) : super(key: key);

  @override
  State<SelfFoodOrder> createState() => _SelfFoodOrderState();
}

class _SelfFoodOrderState extends State<SelfFoodOrder> {
  var persons = TextEditingController();
  var remarks = TextEditingController();
  int op = 0;
  int check = -1;
  int cTable = -1;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          FoodOrderProvider(isTakeAway: widget.isTakeAway),
      child: SafeArea(
        child: Scaffold(
          // appBar: Utils.appBarWidget(),
          body: SingleChildScrollView(
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
                Consumer<FoodOrderProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    //  selfOrder(widget.isTakeAway);

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          selfOrder(widget.isTakeAway),
                          Utils.getHeight(20.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: CColors.textFieldFill,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                getImageRow(
                                  "Select Restaurant",
                                  "assets/icons/arrow_left.png",
                                  "Swipe Right",
                                  /*  (check >= 0)
                                        ? "assets/icons/ic_not_paid.png"
                                        : "assets/icons/ic_paid.png",
                                    "Step 1"*/
                                ),
                                /*getImageRow("",
                                    "assets/icons/arrow_left.png",
                                    "Swipe Right"),*/
                                Utils.getHeight(20.h),
                                SizedBox(
                                  height: 120.h,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: provider.restaurantList.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, i) {
                                      return getRestrurants(
                                          provider.restaurantList[i], provider);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // hall container to be build here

                          Utils.getHeight(20.h),
                          (provider.selectedRestaurant != null &&
                                  provider.halllList.isNotEmpty)
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    color: CColors.textFieldFill,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      getImageRow(
                                          "Select Hall",
                                          "assets/icons/arrow_left.png",
                                          "Swipe Right"),
                                      // getImageRow(
                                      //     "Select Hall",
                                      //     (check >= 0)
                                      //         ? "assets/icons/ic_not_paid.png"
                                      //         : "assets/icons/ic_paid.png",
                                      //     "Step 2"),
                                      Utils.getHeight(20.h),
                                      SizedBox(
                                        height: 120.h,
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: provider.halllList.length,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemBuilder: (ctx, i) {
                                            return getHalls(
                                                provider.halllList[i],
                                                provider);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : getPlaceHolder(provider),

                          //
                          Utils.getHeight(20.h),
                          (provider.selectedRestaurant != null &&
                                  provider.tableList.isNotEmpty)
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    color: CColors.textFieldFill,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      getRow("Select Table"),
                                      GridView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: provider.tableList.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return buildInkWell(
                                              provider.tableList[index],
                                              provider);
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : getPlaceHolder(provider)
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell buildInkWell(TableModel model, FoodOrderProvider provider) {
    return InkWell(
      onTap: () {
        provider.selectTable(model, context);
      },

      // table size
      child: Card(
        color:
            (provider.selectedTable == model) ? CColors.ylwBtn : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Image(
              image: AssetImage("assets/icons/ic_table.png"),
              width: 23,
              height: 23,
            ),
            Center(
              child: Text(
                getTableNo(model.tableNo1 ?? ""),
                style: TextStyle(color: CColors.blue, fontSize: 11),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getTableNo(String text) {
    if (text.contains("Table No ")) {
      return text.replaceAll("No ", "");
    }
    return text;
  }

  Row getRow(String txt) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        txt,
        style: TextStyle(
            color: CColors.blue, fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ]);
  }

  Row getImageRow(String txt, String img, String stp) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          txt,
          style: TextStyle(
              color: CColors.blue, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            Text(
              stp,
              style: const TextStyle(color: Colors.green),
            ),
            Utils.getWidth(8.w),
            Image(image: AssetImage(img))
          ],
        ),
      ],
    );
  }

//get hall
  Widget getHalls(Hall model, FoodOrderProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                provider.selectHall(model, context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: 60,
                decoration: BoxDecoration(
                  color: (model == provider.selectedHall)
                      ? CColors.ylwBtn
                      : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  margin: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      color: CColors.textFieldFill,
                      borderRadius: BorderRadius.circular(15)),
                  child: Image(
                    image: AssetImage('assets/icons/hall.png'),
                  ),
                ),
              ),
            ),
          ),
          Utils.getHeight(10.h),
          Text(
            model.hall ?? "",
            style: TextStyle(
              color: CColors.blue,
              fontSize: 16,
            ),
          ),
          Utils.getHeight(12.h),
        ],
      ),
    );
  }

  Widget selfOrder(bool isTakeaway) {
    if (isTakeaway == true) {
      return Text(
        "Take Away Order",
        style: TextStyle(
            color: CColors.blue, fontSize: 16, fontWeight: FontWeight.w700),
      );
    } else {
      return Text(
        "Self Food Order",
        style: TextStyle(
            color: CColors.blue, fontSize: 16, fontWeight: FontWeight.w700),
      );
    }
  }

  //
  Widget getRestrurants(RestaurantModel model, FoodOrderProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                provider.selectRestaurant(model, context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: 60,
                decoration: BoxDecoration(
                  color: (model == provider.selectedRestaurant)
                      ? CColors.ylwBtn
                      : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  margin: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      color: CColors.textFieldFill,
                      borderRadius: BorderRadius.circular(15)),
                  child: Image(
                    image: NetworkImage(
                            "${"http://182.180.172.240"}${provider.isTakeAway ? '' : "/"}${model.icon}")
                        as ImageProvider,
                    errorBuilder: (ctx, obj, stk) {
                      return Image.asset("assets/icons/knife.png");
                    },
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Utils.getHeight(10.h),
          Text(
            model.name ?? "",
            style: TextStyle(
              color: CColors.blue,
              fontSize: 16,
            ),
          ),
          Utils.getHeight(12.h),
        ],
      ),
    );
  }

  Widget getPlaceHolder(FoodOrderProvider provider) {
    if (provider.isTableLoading) {
      return Padding(
        padding: EdgeInsets.only(top: 50),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return const SizedBox();
  }

  Widget getPlaceHolderHall(FoodOrderProvider provider) {
    if (provider.ishallLoading) {
      return Padding(
        padding: EdgeInsets.only(top: 50),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return const SizedBox();
  }
}

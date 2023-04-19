import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymkhana_club/screens/profile/profile_page.dart';
import 'package:gymkhana_club/shared/providers/data_provider.dart';
import 'package:provider/provider.dart';

import '../../extras/colors.dart';
import '../../shared/models/cart_items_model.dart';
import '../../shared/providers/cart_menu_provider.dart';
import '../../widgets/utils.dart';

class CartMenu extends StatefulWidget {
  final int resId;
  final bool isTakeAway;
  final String tableNo;

  const CartMenu(
      {Key? key,
        required this.resId,
        required this.isTakeAway,
        required this.tableNo})
      : super(key: key);

  @override
  State<CartMenu> createState() => _CartMenuState();
}

class _CartMenuState extends State<CartMenu> {
  late num limit;
  late num availLimit;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CartMenuProvider(
          resId: widget.resId,
          isTakeAway: widget.isTakeAway,
          context: context,
          tableNo: widget.tableNo),
      child: Consumer<CartMenuProvider>(
        builder: (context, provider, child) {
          this.provider = provider;
          this.limit = context.read<DataProvider>().userModel.limit!;
          return Scaffold(
            appBar: Utils.appBarWidget(),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getH1("Cart Menu"),
                        if (provider.isLoading)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        else ...[
                          Utils.getHeight(40.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 15.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: CColors.textFieldFill,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getH2("Order Details"),
                                Utils.getHeight(20.h),
                                Consumer<DataProvider>(
                                  builder: (context, provider, child) {

                                    return yText(
                                        "Total Bill ${totalBill(provider).toInt()}       Food Limit ${provider.userModel.limit?.toInt()}");
                                  },
                                ),
                                Utils.getHeight(20.h),
                                Consumer<DataProvider>(
                                  builder: (context, provider, child) {

                                    return yText(
                                        "Available Limit ${availableLimit(provider).toInt()} ");
                                  },
                                ),
                                Utils.getHeight(20.h),
                                Row(
                                  children: [
                                    getH3("Customer ID:"),
                                    getH2(
                                        "  ${provider.cartDetailsModel?.customerId ?? ""}")
                                  ],
                                ),
                                Utils.getHeight(10.h),
                                Consumer<DataProvider>(
                                  builder: (context, provider, child) {
                                    return Row(
                                      children: [
                                        getH3("Name:"),
                                        getH2(
                                            "  ${provider.userModel.name ?? ""}")
                                      ],
                                    );
                                  },
                                ),
                                Utils.getHeight(10.h),
                                if (widget.tableNo.isNotEmpty &&
                                    !widget.isTakeAway)
                                  Row(
                                    children: [
                                      getH3("Table :"),
                                      // getH2(
                                      //     "  ${provider.cartDetailsModel?.tableNo ?? ""}"),
                                      getH2("  ${widget.tableNo}"),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          Utils.getHeight(40.h),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 15.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: CColors.textFieldFill,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Center(child: getT3("Qty")),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: getT3("Item Details"),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: getT3("Price"),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: getT3("Amount"),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.black12,
                                  thickness: 2,
                                ),
                                ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: provider.cartItems.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return itemWidget(
                                        provider.cartItems[index]);
                                  },
                                ),
                                const Divider(
                                  color: Colors.black12,
                                  thickness: 2,
                                ),
                                if (widget.isTakeAway)
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      getH3("Take away service charges :"),
                                      // getH2(
                                      //     "  ${provider.cartDetailsModel?.tableNo ?? ""}"),
                                      getH2("  ${provider.cartDetailsModel?.takeAwayCharges ?? ""}  %  ${percentageAmount(provider,widget.isTakeAway)}"),
                                    ],
                                  ),
                                if (!widget.isTakeAway)
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      getH3("Table service charges :"),
                                      // getH2(
                                      //     "  ${provider.cartDetailsModel?.tableNo ?? ""}"),
                                      // getH2("  ${provider.cartDetailsModel?.tableServiceCharges ?? ""}  % ${percentageAmount(provider,widget.isTakeAway)}"),
                                      getH2("  ${provider.cartDetailsModel?.tableServiceCharges?.toInt() ?? ""}  % ${percentageAmount(provider,widget.isTakeAway).toInt()}"),

                                    ],
                                  ),
                                Utils.getHeight(15.h),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    getH2("Grand Total"),
                                    getH3("${grandTotal(provider,widget.isTakeAway).toInt()}"),
                                  ],
                                ),
                                Utils.getHeight(20.h),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      num sum = grandTotal(provider,widget.isTakeAway);


                                      int balance = availLimit.toInt() - sum.toInt() ;

                                      provider.placeOrder(balance,limit);


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
                                        "Place Order",
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
                          ),
                        ],
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  num grandTotal(CartMenuProvider provider , bool isTakeAway) {
    num? sum = 0;
    int total = (provider.cartItems.fold(
      0,
          (previousValue, element) =>
      previousValue + (element.amount?.toInt() ?? 0),
    ));
    if (!isTakeAway) {
      sum = provider.cartDetailsModel?.tableServiceCharges;
    }

    else {
      sum = provider.cartDetailsModel?.takeAwayCharges;
    }
    num chargesPercent = sum! / 100 ;
    num valueToAdd = chargesPercent * total;

    return (valueToAdd! + total);
  }

  num percentageAmount(CartMenuProvider provider , bool isTakeAway) {
    num? sum = 0;
    int total = (provider.cartItems.fold(
      0,
          (previousValue, element) =>
      previousValue + (element.amount?.toInt() ?? 0),
    ));
    if (!isTakeAway) {
      sum = provider.cartDetailsModel?.tableServiceCharges;
    }

    else {
      sum = provider.cartDetailsModel?.takeAwayCharges;
    }
    num chargesPercent = sum! / 100 ;
    num valueToAdd = chargesPercent * total;

    return (valueToAdd);
  }
  num totalBill(DataProvider provider ) {
    num total = (provider.userModel!.lastBill?.toDouble() ?? 0) +
        (provider.userModel!.foodBill?.toDouble() ?? 0);
    return total;
  }
  num availableLimit(DataProvider provider ) {
    num total = (provider.userModel!.lastBill?.toDouble() ?? 0) +
        (provider.userModel!.foodBill?.toDouble() ?? 0);
    availLimit =(provider.userModel!.limit?.toDouble() ?? 0) - total   ;
    return availLimit;
  }

  Row itemWidget(CartItemsModel model) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Row(
            children: [
              minusBtn(model),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  model.qty.toString(),
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              plusBtn(model),
              GestureDetector(
                onTap: () {
                  provider.removeCartItem(model);
                },
                child: Icon(
                  Icons.delete,
                  size: 32,
                  color: CColors.ylwBtn,
                ),
              ),
              // Utils.getWidth(15.w),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: getT2(model.itemName ?? ""),
        ),
        Expanded(
          flex: 2,
          child: getT2("${model.unitPrice}"),
        ),
        Expanded(
          flex: 2,
          child: getT2("${model.amount}"),
        ),
      ],
    );
  }

  Text getT2(String txt) {
    return Text(
      txt,
      style: TextStyle(
        color: CColors.blue,
        fontSize: 13,
      ),
    );
  }

  Text getT3(String txt) {
    return Text(
      txt,
      style: TextStyle(
        color: CColors.blue,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  late CartMenuProvider provider;

  Widget minusBtn(CartItemsModel model) {
    return GestureDetector(
      onTap: () {
        provider.decrementCartItem(model);
      },
      child: Container(
        height: 35.h,
        width: 35.w,
        decoration: BoxDecoration(
          border: Border.all(color: CColors.ylwBtn, width: 2),
          shape: BoxShape.circle,
        ),
        child: const Center(
          // child: Text(
          //   "-",
          //   style: TextStyle(color: CColors.blue, fontSize: 30),
          // ),
          child: Icon(Icons.remove),
        ),
      ),
    );
  }

  Widget plusBtn(CartItemsModel model) {
    return GestureDetector(
      onTap: () {
        provider.incrementCartItem(model);
      },
      child: Container(
        height: 35.h,
        width: 35.w,
        decoration: BoxDecoration(
          color: CColors.ylwBtn,
          border: Border.all(color: CColors.ylwBtn, width: 2),
          shape: BoxShape.circle,
        ),
        child: const Center(
          // child: Text(
          //   "+as",
          //   style: TextStyle(color: CColors.blue, fontSize: 30),
          // ),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Text getH1(String txt) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: 13,
        color: CColors.blue,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Text getH2(String txt) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: 13,
        color: CColors.blue,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Text getH3(String txt) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: 13,
        color: CColors.blue,
      ),
    );
  }

  Text yText(String txt) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: 13,
        color: CColors.ylwBtn,
      ),
    );
  }

  Text getText(String txt) {
    return Text(
      txt,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

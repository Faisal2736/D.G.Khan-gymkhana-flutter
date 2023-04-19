import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymkhana_club/extras/fucntions.dart';
import 'package:gymkhana_club/shared/models/menu_item_model.dart';
import 'package:gymkhana_club/widgets/utils.dart';

import '../extras/colors.dart';

class MenuItemWidget extends StatefulWidget {
  final Function(String size, int quantity, double price, String remarks) onAdd;
  final MenuItemModel model;

  const MenuItemWidget({Key? key, required this.model, required this.onAdd})
      : super(key: key);

  @override
  State<MenuItemWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  final fullController = TextEditingController();
  final halfController = TextEditingController();
  final smallController = TextEditingController();

  // final fullController = TextEditingController();
  int fullQuantity = 1;
  int halfQuantity = 1;
  int smallQuantity = 1;
  int xlQuantity = 0;
  bool added = false;
  bool added2 = false;
  bool added3 = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  widget.model.name ?? "",
                  style: TextStyle(
                      color: CColors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Utils.getHeight(20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if ((widget.model.priceF?.toInt() ?? 0) > 0) ...[
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                             "${widget.model.showF.toString()} ${widget.model.priceF.toString()}",
                            style: TextStyle(
                                color: CColors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Utils.getHeight(7.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: textFieldWidget(fullController)),
                            Row(
                              children: [
                                minusBtn(
                                  onTap: () {
                                    if (fullQuantity < 1) {
                                      return;
                                    }
                                    setState(
                                      () {
                                        fullQuantity--;
                                      },
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    fullQuantity.toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                plusBtn(
                                  onTap: () {
                                    setState(
                                      () {
                                        fullQuantity++;
                                      },
                                    );
                                  },
                                ),
                                Utils.getWidth(15.w),
                                GestureDetector(
                                  onTap: () async {
                                    if (fullQuantity < 1) {
                                      Functions.showSnackBar(context, "Please Add some quantity");
                                      return;
                                    }
                                    if (added) {
                                      Functions.showSnackBar(
                                          context, "Please Go to cart to edit");
                                      return;
                                    }
                                    await widget.onAdd(
                                        "Full",
                                        fullQuantity,
                                        widget.model.priceF?.toDouble() ?? 0.0,
                                        fullController.text.trim());
                                    added = true;
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: CColors.blue,
                                    ),
                                    child: const Center(
                                      child: Image(
                                        image: AssetImage(
                                            "assets/icons/ic_cart.png"),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                      if ((widget.model.priceH?.toInt() ?? 0) > 0) ...[
                        Utils.getHeight(40.h),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "${widget.model.showH.toString()} ${widget.model.priceH.toString()}",
                            style: TextStyle(
                                color: CColors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Utils.getHeight(7.h),
                        Row(
                          children: [
                            Expanded(child: textFieldWidget(halfController)),
                            minusBtn(
                              onTap: () {
                                if (halfQuantity < 1) {
                                  return;
                                }
                                setState(
                                  () {
                                    halfQuantity--;
                                  },
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                halfQuantity.toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            plusBtn(
                              onTap: () {
                                setState(
                                  () {
                                    halfQuantity++;
                                  },
                                );
                              },
                            ),
                            Utils.getWidth(15.w),
                            GestureDetector(
                              onTap: () async {
                                if (halfQuantity < 1) {
                                  Functions.showSnackBar(context, "Please Add some quantity");
                                  return;
                                }
                                if (added2) {
                                  Functions.showSnackBar(
                                      context, "Please Go to cart to edit");
                                  return;
                                }
                                await widget.onAdd(
                                    "Half",
                                    halfQuantity,
                                    widget.model.priceH?.toDouble() ?? 0.0,
                                    halfController.text.trim());
                                added2 = true;
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CColors.blue,
                                ),
                                child: const Image(
                                  image: AssetImage("assets/icons/ic_cart.png"),
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                      if ((widget.model.priceS?.toInt() ?? 0) > 0) ...[
                        Utils.getHeight(40.h),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "${widget.model.showS.toString()} ${widget.model.priceS.toString()}",
                            style: TextStyle(
                                color: CColors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Utils.getHeight(7.h),
                        Row(
                          children: [
                            Expanded(child: textFieldWidget(smallController)),
                            minusBtn(
                              onTap: () {
                                if (smallQuantity < 1) {
                                  return;
                                }
                                setState(
                                  () {
                                    smallQuantity--;
                                  },
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                halfQuantity.toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            plusBtn(
                              onTap: () {
                                setState(
                                  () {
                                    smallQuantity++;
                                  },
                                );
                              },
                            ),
                            Utils.getWidth(15.w),
                            GestureDetector(
                              onTap: () async {
                                if (smallQuantity < 1) {
                                  Functions.showSnackBar(context, "Please Add some quantity");
                                  return;
                                }
                                if (added3) {
                                  Functions.showSnackBar(
                                      context, "Please Go to cart to edit");
                                  return;
                                }
                                widget.onAdd(
                                    "Small",
                                    smallQuantity,
                                    widget.model.priceS?.toDouble() ?? 0.0,
                                    smallController.text.trim());
                                added3 = true;
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CColors.blue,
                                ),
                                child: const Image(
                                  image: AssetImage("assets/icons/ic_cart.png"),
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget textFieldWidget(TextEditingController textEditingController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
            isDense: true,
            border: UnderlineInputBorder(
                borderSide: BorderSide(
              color: CColors.ylwBtn,
            )),
            hintText: "Notes",
            hintStyle: TextStyle(
                color: CColors.ylwBtn,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget minusBtn({required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          border: Border.all(color: CColors.ylwBtn, width: 2),
          shape: BoxShape.circle,
        ),
        // child: Center(
        //     child: Text(
        //   "-",
        //   style: TextStyle(color: CColors.blue, fontSize: 30),
        // )),
        child: const Icon(Icons.remove),
      ),
    );
  }

  Widget plusBtn({required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: CColors.ylwBtn,
          border: Border.all(color: CColors.ylwBtn, width: 2),
          shape: BoxShape.circle,

        ),
        // child: Center(
        //     child: Text(
        //   "+",
        //   style: TextStyle(color: CColors.blue, fontSize: 30),
        // )),
        child: const Icon(Icons.add),
      ),
    );
  }
}

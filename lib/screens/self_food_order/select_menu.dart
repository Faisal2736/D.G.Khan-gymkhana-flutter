import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymkhana_club/extras/constants.dart';
import 'package:gymkhana_club/screens/self_food_order/cart_menu.dart';
import 'package:provider/provider.dart';

import '../../extras/colors.dart';
import '../../shared/models/menu_model.dart';
import '../../shared/providers/menu_view_provider.dart';
import '../../widgets/menu_item_widget.dart';
import '../../widgets/utils.dart';
import '../../widgets/white_text_field.dart';

class SelectMenu extends StatefulWidget {
  final int resId;
  final String? tableNo;
  final bool isTakeAway;

  const SelectMenu(
      {Key? key,
      required this.resId,
      required this.tableNo,
      required this.isTakeAway})
      : super(key: key);

  @override
  State<SelectMenu> createState() => _SelectMenuState();
}

class _SelectMenuState extends State<SelectMenu> {
  var persons = TextEditingController();
  var remarks = TextEditingController();
  int op = 0;
  int check = -1;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MenuViewProvider(
          context: context,
          resId: widget.resId,
          tableNo: widget.tableNo,
          isTakeAway: widget.isTakeAway),
      child: Scaffold(
        appBar: Utils.appBarWidget(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  // Get.to(const ProfilePage());
                },
                child: Utils.getProfileContainer(),
              ),
              Utils.getHeight(30.h),
              Consumer<MenuViewProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WhiteTextFieldWidget(
                          textEditingController: provider.controller,
                          horizontalMargin: 0,
                          labelText: "Search",
                          node: provider.node,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              provider.searchMenu();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.search),
                            ),
                          ),
                          onDone: (value) {
                            provider.searchMenu();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Select Menu",
                            style: TextStyle(
                                color: CColors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Utils.getHeight(20.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          decoration: BoxDecoration(
                            color: CColors.textFieldFill,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              getImageRow("Menu", "assets/icons/arrow_left.png",
                                  "Swipe Right"),
                              // getImageRow(
                              //     "Menu",
                              //     (check >= 0)
                              //         ? "assets/icons/ic_paid.png"
                              //         : "assets/icons/ic_not_paid.png",
                              //     "Step 4"),
                              Utils.getHeight(20.h),
                              Container(
                                height: 130.h,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: provider.menuList.length,
                                  itemBuilder: (ctx, i) {
                                    return getRestrurants(
                                        provider.menuList[i], provider);
                                  },
                                ),
                              ),
                              Utils.getHeight(20.h),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${provider.selectedMenu?.mainHead ?? ""}",
                                      style: TextStyle(
                                          color: CColors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CartMenu(
                                                isTakeAway: widget.isTakeAway,
                                                resId: widget.resId,
                                                tableNo: provider.tableNo ?? "",
                                              ),
                                            ),
                                          );
                                        },
                                        child: badges.Badge(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => CartMenu(
                                                  isTakeAway: widget.isTakeAway,
                                                  resId: widget.resId,
                                                  tableNo: provider.tableNo ?? "",
                                                ),
                                              ),
                                            );

                                          },
                                          badgeContent: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle),
                                            height: 15,
                                            width: 13,
                                            child: Text(
                                              "${provider.cartNumber}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          child: Image(
                                            image: const AssetImage(
                                                "assets/icons/ic_cart.png"),
                                            color: CColors.ylwBtn,
                                            height: 30,
                                            width: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Utils.getHeight(20.h),
                              if (provider.selectedMenu != null ||
                                  provider.menuItemsList.isNotEmpty)
                                ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: provider.menuItemsList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return MenuItemWidget(
                                      model: provider.menuItemsList[index],
                                      onAdd: (size, quantity, price, remarks) {
                                        provider.addToCard(
                                            provider.menuItemsList[index],
                                            size,
                                            quantity,
                                            price,
                                            remarks);
                                      },
                                    );
                                    // return (check >= 0)
                                    //     ? Padding(
                                    //         padding: EdgeInsets.symmetric(
                                    //             vertical: 10.h),
                                    //         child: Container(
                                    //           decoration: BoxDecoration(
                                    //             color: Colors.white,
                                    //             borderRadius:
                                    //                 BorderRadius.circular(15),
                                    //           ),
                                    //           child: Column(
                                    //             children: [
                                    //               Row(
                                    //                 crossAxisAlignment:
                                    //                     CrossAxisAlignment.start,
                                    //                 children: [
                                    //                   Expanded(
                                    //                     child: Padding(
                                    //                       padding:
                                    //                           const EdgeInsets
                                    //                               .all(8.0),
                                    //                       child: Column(
                                    //                         mainAxisAlignment:
                                    //                             MainAxisAlignment
                                    //                                 .start,
                                    //                         crossAxisAlignment:
                                    //                             CrossAxisAlignment
                                    //                                 .start,
                                    //                         children: [
                                    //                           Text(
                                    //                             "Desi Murgh",
                                    //                             style: TextStyle(
                                    //                                 color: CColors
                                    //                                     .blue,
                                    //                                 fontSize: 20,
                                    //                                 fontWeight:
                                    //                                     FontWeight
                                    //                                         .w700),
                                    //                           ),
                                    //                           Utils.getHeight(
                                    //                               20.h),
                                    //                           Text(
                                    //                             "Notes",
                                    //                             style: TextStyle(
                                    //                                 color: CColors
                                    //                                     .ylwBtn,
                                    //                                 fontSize: 16,
                                    //                                 fontWeight:
                                    //                                     FontWeight
                                    //                                         .w500),
                                    //                           ),
                                    //                         ],
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                   Expanded(
                                    //                     child: Column(
                                    //                       crossAxisAlignment:
                                    //                           CrossAxisAlignment
                                    //                               .end,
                                    //                       children: [
                                    //                         Padding(
                                    //                           padding:
                                    //                               const EdgeInsets
                                    //                                   .all(8.0),
                                    //                           child: Column(
                                    //                             children: [
                                    //                               Align(
                                    //                                 alignment:
                                    //                                     Alignment
                                    //                                         .topRight,
                                    //                                 child: Text(
                                    //                                   "Full 1234",
                                    //                                   style: TextStyle(
                                    //                                       color: CColors
                                    //                                           .blue,
                                    //                                       fontSize:
                                    //                                           18,
                                    //                                       fontWeight:
                                    //                                           FontWeight.w500),
                                    //                                 ),
                                    //                               ),
                                    //                               Utils.getHeight(
                                    //                                   7.h),
                                    //                               Row(
                                    //                                 children: [
                                    //                                   minusBtn(),
                                    //                                   const Padding(
                                    //                                     padding:
                                    //                                         EdgeInsets.all(
                                    //                                             8.0),
                                    //                                     child:
                                    //                                         Text(
                                    //                                       "1",
                                    //                                       style: TextStyle(
                                    //                                           fontSize:
                                    //                                               20),
                                    //                                     ),
                                    //                                   ),
                                    //                                   plusBtn(),
                                    //                                   Utils.getWidth(
                                    //                                       15.w),
                                    //                                   Container(
                                    //                                     height:
                                    //                                         30,
                                    //                                     width: 30,
                                    //                                     decoration:
                                    //                                         BoxDecoration(
                                    //                                       shape: BoxShape
                                    //                                           .circle,
                                    //                                       color: CColors
                                    //                                           .blue,
                                    //                                     ),
                                    //                                     child:
                                    //                                         const Image(
                                    //                                       image: AssetImage(
                                    //                                           "assets/icons/ic_cart.png"),
                                    //                                       color: Colors
                                    //                                           .white,
                                    //                                     ),
                                    //                                   )
                                    //                                 ],
                                    //                               ),
                                    //                               Utils.getHeight(
                                    //                                   40.h),
                                    //                               Align(
                                    //                                 alignment:
                                    //                                     Alignment
                                    //                                         .topRight,
                                    //                                 child: Text(
                                    //                                   "Half 1243",
                                    //                                   style: TextStyle(
                                    //                                       color: CColors
                                    //                                           .blue,
                                    //                                       fontSize:
                                    //                                           18,
                                    //                                       fontWeight:
                                    //                                           FontWeight.w500),
                                    //                                 ),
                                    //                               ),
                                    //                               Utils.getHeight(
                                    //                                   7.h),
                                    //                               Row(
                                    //                                 children: [
                                    //                                   minusBtn(),
                                    //                                   const Padding(
                                    //                                     padding:
                                    //                                         EdgeInsets.all(
                                    //                                             8.0),
                                    //                                     child:
                                    //                                         Text(
                                    //                                       "1",
                                    //                                       style: TextStyle(
                                    //                                           fontSize:
                                    //                                               20),
                                    //                                     ),
                                    //                                   ),
                                    //                                   plusBtn(),
                                    //                                   Utils.getWidth(
                                    //                                       15.w),
                                    //                                   Container(
                                    //                                     height:
                                    //                                         30,
                                    //                                     width: 30,
                                    //                                     decoration:
                                    //                                         BoxDecoration(
                                    //                                       shape: BoxShape
                                    //                                           .circle,
                                    //                                       color: CColors
                                    //                                           .blue,
                                    //                                     ),
                                    //                                     child:
                                    //                                         const Image(
                                    //                                       image: AssetImage(
                                    //                                           "assets/icons/ic_cart.png"),
                                    //                                       color: Colors
                                    //                                           .white,
                                    //                                     ),
                                    //                                   )
                                    //                                 ],
                                    //                               ),
                                    //                             ],
                                    //                           ),
                                    //                         )
                                    //                       ],
                                    //                     ),
                                    //                   ),
                                    //                 ],
                                    //               )
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       )
                                    //     : SizedBox();
                                  },
                                )
                              else if (provider.isItemsLoading)
                                Center(
                                  child: CircularProgressIndicator(),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget menuItemWidget(MenuItemModel model) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 10.h),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //       child: Column(
  //         children: [
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Expanded(
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         model.name ?? "",
  //                         style: TextStyle(
  //                             color: CColors.blue,
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.w700),
  //                       ),
  //                       Utils.getHeight(20.h),
  //                       Text(
  //                         "Notes",
  //                         style: TextStyle(
  //                             color: CColors.ylwBtn,
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.w500),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Column(
  //                         children: [
  //                           Align(
  //                             alignment: Alignment.topRight,
  //                             child: Text(
  //                               model.priceF.toString(),
  //                               style: TextStyle(
  //                                   color: CColors.blue,
  //                                   fontSize: 18,
  //                                   fontWeight: FontWeight.w500),
  //                             ),
  //                           ),
  //                           Utils.getHeight(7.h),
  //                           Row(
  //                             children: [
  //                               minusBtn(),
  //                               const Padding(
  //                                 padding: EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "1",
  //                                   style: TextStyle(fontSize: 20),
  //                                 ),
  //                               ),
  //                               plusBtn(),
  //                               Utils.getWidth(15.w),
  //                               Container(
  //                                 height: 30,
  //                                 width: 30,
  //                                 decoration: BoxDecoration(
  //                                   shape: BoxShape.circle,
  //                                   color: CColors.blue,
  //                                 ),
  //                                 child: const Image(
  //                                   image:
  //                                       AssetImage("assets/icons/ic_cart.png"),
  //                                   color: Colors.white,
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                           Utils.getHeight(40.h),
  //                           Align(
  //                             alignment: Alignment.topRight,
  //                             child: Text(
  //                               model.priceH.toString(),
  //                               style: TextStyle(
  //                                   color: CColors.blue,
  //                                   fontSize: 18,
  //                                   fontWeight: FontWeight.w500),
  //                             ),
  //                           ),
  //                           Utils.getHeight(7.h),
  //                           Row(
  //                             children: [
  //                               minusBtn(),
  //                               const Padding(
  //                                 padding: EdgeInsets.all(8.0),
  //                                 child: Text(
  //                                   "1",
  //                                   style: TextStyle(fontSize: 20),
  //                                 ),
  //                               ),
  //                               plusBtn(),
  //                               Utils.getWidth(15.w),
  //                               Container(
  //                                 height: 30,
  //                                 width: 30,
  //                                 decoration: BoxDecoration(
  //                                   shape: BoxShape.circle,
  //                                   color: CColors.blue,
  //                                 ),
  //                                 child: const Image(
  //                                   image:
  //                                       AssetImage("assets/icons/ic_cart.png"),
  //                                   color: Colors.white,
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Row getImageRow(String txt, String img, String stp) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          txt,
          style: TextStyle(
            color: CColors.blue,
            fontSize: 16,
          ),
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

  Column getRestrurants(MenuModel model, MenuViewProvider provider) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              // check = i;
              // setState(() {});
              provider.selectMenu(model);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 5),
              width: 70,
              decoration: BoxDecoration(
                color: (provider.selectedMenu == model)
                    ? CColors.ylwBtn
                    : Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                margin: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: CColors.textFieldFill,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Image(
                    image: NetworkImage("${Constants.baseUrl}/${model.icon}"),
                    errorBuilder: (_, _1, _2) {
                      return Image.asset("assets/logos/spoon.PNG");
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        Utils.getHeight(5.h),
        Text(
          model.mainHead ?? "",
          style: TextStyle(
            color: CColors.blue,
            fontSize: 16,
          ),
        ),
        Utils.getHeight(10.h),
      ],
    );
  }
}

import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gymkhana_club/extras/constants.dart';
import 'package:gymkhana_club/extras/fucntions.dart';
import 'package:gymkhana_club/merge.dart';
import 'package:gymkhana_club/prayer_module/adhan.dart';
import 'package:gymkhana_club/screens/auth/login_screen.dart';
import 'package:gymkhana_club/screens/homepage_sections/epool.dart';
import 'package:gymkhana_club/screens/homepage_sections/help_desk.dart';
import 'package:gymkhana_club/screens/homepage_sections/room_reservation.dart';
import 'package:gymkhana_club/screens/homepage_sections/table_reservation.dart';
import 'package:gymkhana_club/screens/profile/profile_page.dart';
import 'package:gymkhana_club/screens/profile/widgets/profile_widgets.dart';
import 'package:gymkhana_club/screens/self_food_order/self_food_order.dart';
import 'package:gymkhana_club/shared/service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../extras/colors.dart';
import '../../prayer_module/screen/adhanscreen.dart';
import '../../prayer_module/screen/loadingscreen.dart';
import '../../shared/providers/data_provider.dart';
import '../../widgets/utils.dart';
import '../food/food_screen.dart';
import '../homepage_sections/member_leger.dart';
import '../self_food_order/select_menu.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> images = [
    "https://cdn.pixabay.com/photo/2016/11/18/14/05/brick-wall-1834784__340.jpg",
    "https://cdn.pixabay.com/photo/2017/08/03/21/48/drinks-2578446__340.jpg",
    "https://cdn.pixabay.com/photo/2017/01/24/03/54/urban-2004494__340.jpg",
    "https://cdn.pixabay.com/photo/2016/11/29/12/18/camera-1869430__340.jpg",
    "https://cdn.pixabay.com/photo/2020/01/30/21/24/shop-4806610__340.jpg",
  ];
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: Utils.appBarWidget(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: Utils.getProfileContainer(),
                ),
                Utils.getHeight(30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Last Bill",
                        style: TextStyle(
                          color: CColors.blue,
                          fontSize: 16,
                        ),
                      ),
                      Utils.getHeight(10.h),
                      ProfileWidgets.lastBill(),
                      Utils.getHeight(10.h),
                      Text(
                        "Food",
                        style: TextStyle(
                          color: CColors.blue,
                          fontSize: 16,
                        ),
                      ),
                      Utils.getHeight(5.h),
                      InkWell(
                        onTap: () {
                          Get.to(const FoodScreen());
                        },
                        child: ProfileWidgets.foodBill(),
                      ),
                      Utils.getHeight(15.h),
                      Text(
                        "Your Menu",
                        style: TextStyle(
                          color: CColors.blue,
                          fontSize: 16,
                        ),
                      ),
                      Utils.getHeight(15.h),
                      Row(
                        children: [
                          getIconBox("assets/logos/profile.PNG", "Profile", () {
                            Get.to(const ProfilePage());
                          }),
                          getIconBox("assets/logos/book.PNG", "Member Ledger",
                                  () {
                                Get.to(const MemberLedger());
                              }),
                          getIconBox("assets/logos/spoon.PNG", "Food Bills",
                                  () {
                                Get.to(const FoodScreen());
                              }),
                        ],
                      ),
                      Utils.getHeight(15.h),
                      Row(
                        children: [
                          getIconBox(
                              "assets/logos/reserve.PNG", "Table \nReservation",
                                  () {
                                Get.to(const TableReservation());
                              }),
                          getIconBox(
                              "assets/logos/boxes.PNG", "Room \nReservation",
                                  () {
                                Get.to(const RoomReservation());
                              }),
                          getIconBox("assets/logos/profile.PNG", "Help\n Desk",
                                  () {
                                Get.to(const HelpDesk());
                              }),
                        ],
                      ),
                      Utils.getHeight(15.h),
                      Row(
                        children: [
                          getIconBox(
                              "assets/logos/weather.png", "Weather\nUpdate",
                                  () {
                                Get.to(const Merge());
                              }),
                          getIconBox("assets/logos/prayer.png", "Prayer Timing",
                                  () {
                                Get.to(LoadingScreen(cityName: "Okara"));
                              }),
                          getIconBox("assets/logos/epooling.png", "E-Polling", () {
                            Get.to(const Epool());
                          }),
                        ],
                      ),
                      Utils.getHeight(15.h),
                      Row(
                        children: [
                          getIconBox("assets/icons/ic_self_order.png",
                              "Self Food\n Order", () {
                                navigate(false);
                              }),
                          getIconBox("assets/logos/take_away.PNG", "Take Away",
                                  () {
                                navigate(true);
                              }),
                          getIconBox(
                              "assets/logos/payment.PNG", "Payment", () {}),
                        ],
                      ),
                      Utils.getHeight(15.h),
                      Row(
                        children: [
                          getIconBox("assets/logos/logout.PNG", "Log Out", () {
                            logout();
                          }),
                          const Expanded(
                            flex: 2,
                            child: SizedBox(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Utils.getHeight(15.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Text(
                    "Promotions",
                    style: TextStyle(
                      color: CColors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
                Utils.getHeight(15.h),
                CarouselSlider.builder(
                  itemCount: provider.promotionImages.length,
                  itemBuilder: (ctx, index, realIdx) {
                    return Container(
                      height: 200,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          child: Image(
                            image: NetworkImage(
                                "${Constants.baseUrl}${provider.promotionImages[index]}"
                              // widget.images[index],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    viewportFraction: 0.9,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Expanded getIconBox(String img, String txt, Function onTap) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 135.h,
          child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: AssetImage(img),
                  height: 25,
                  color: CColors.blue,
                  fit: BoxFit.fill,
                ),
                Text(
                  txt,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: CColors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> navigate(bool takeAway) async {
    final apiService = ApiService();
    Functions.showLoaderDialog(context);
    try {
      final memberId = context.read<DataProvider>().memberId;
      var url = "FoodOrdering/CheckRunning?MemberId=$memberId";
      var response = await apiService.get(url);
      var responseBody = jsonDecode(response.body);
      var isRunning = responseBody["isRunning"] ?? false;
      Navigator.of(context).pop();
      if (isRunning) {
        debugPrint("isRunning takeawy : ${takeAway}");
        var tableNo = responseBody["tableNumber"] ?? "";
        var resId = responseBody["resId"] ?? 0;
        await clearCart(memberId,tableNo,resId);
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return SelectMenu(
              tableNo: tableNo,
              isTakeAway: takeAway,
              resId: resId,
            );
          },
        ));
      } else {
        var tableNo = responseBody["tableNumber"] ?? "";
        var resId = responseBody["resId"] ?? 0;
        await clearCart(memberId,tableNo,resId);

        debugPrint("takeway : ${takeAway}");
        Get.to(SelfFoodOrder(
          isTakeAway: takeAway,
        ));
      }
      return;
    } catch (e) {
      Functions.showSnackBar(context, "Something went wrong");
    }
    Navigator.of(context).pop();
  }

  Future<void> clearCart(var memberId ,var tableNo, var resId) async {
    final apiService = ApiService();
    var url = "Cart/ClearCart?memberId=${memberId}&tableNo=${tableNo}&resId=${resId}";
    var response = await apiService.delete(url);  }

  Future<void> logout() async {
    final apiService = ApiService();
    Functions.showLoaderDialog(context);
    try {
      final memberId = context.read<DataProvider>().memberId;
      var url = "Account/logOut?memberId=$memberId";
      var response = await apiService.deleteV2(url);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("memberId", "");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
              (route) => false);
      return;
    } catch (e) {
      Functions.showSnackBar(context, "Something went wrong");
    }
    Navigator.of(context).pop();
  }
}

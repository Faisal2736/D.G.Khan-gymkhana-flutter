import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymkhana_club/screens/self_food_order/select_menu.dart';
import 'package:provider/provider.dart';

import '../../extras/fucntions.dart';
import '../models/hall_model.dart';
import '../models/restaurant_model.dart';
import '../models/table_model.dart';
import '../service.dart';
import 'data_provider.dart';

class FoodOrderProvider extends ChangeNotifier {
  bool isLoading = true;
  bool isTableLoading = false;
  bool ishallLoading = false;
  late bool isTakeAway;
  final ApiService _apiService = ApiService();
  List<RestaurantModel> restaurantList = [];
  List<TableModel> tableList = [];
  List<Hall> halllList = [];

  RestaurantModel? selectedRestaurant;
  Hall? selectedHall;
  TableModel? selectedTable;

  FoodOrderProvider({required this.isTakeAway}) {
    getRestaurants();

  }

  Future<void> getRestaurants() async {
    try {
      debugPrint("here takeaway : ${isTakeAway.toString()}");
      var response = await _apiService
          .get("FoodOrdering/GetRestaurantList?Takeaway=$isTakeAway");
      var body = jsonDecode(response.body);
      List items = body["restaurantList"] ?? [];
      for (var item in items) {
        restaurantList.add(RestaurantModel.fromJson(item));
      }
      debugPrint(response.body.toString());
    } catch (e) {
      debugPrint(e.toString());
      // TODO
    }
    isLoading = false;
    notifyListeners();
  }
  //for halls
  Future<void> getHalls(BuildContext context) async {
    ishallLoading=true;
    notifyListeners();
    var resId= selectedRestaurant?.resId?.toInt() ?? 0;
    var url = "FoodOrdering/GetHallList?resId=$resId";

    try {
      var response = await _apiService.get(url);
      var responseBody = jsonDecode(response.body);
      List items = responseBody["hall"] ?? [];
      halllList = [];
      notifyListeners();
      for (var element in items) {
        halllList.add(Hall.fromJson(element));
      }
    } catch (e) {
      Functions.showSnackBar(context, "Something went wrong");
    }
    ishallLoading = false;
    notifyListeners();
  }


  Future<void> getTables(BuildContext context) async {
    isTableLoading = true;
    notifyListeners();
    final memberId = context.read<DataProvider>().memberId;
    var url = "FoodOrdering/GetTableList";
    var body = {
      "isTakeaway": false,
      "resId": selectedRestaurant?.resId?.toInt() ?? 0,
      "memberId": memberId,
      "hallId": selectedHall?.id?.toInt() ?? 0

    };
    try {
      var response = await _apiService.post(url, body);
      var responseBody = jsonDecode(response.body);
      List items = responseBody["tableList"] ?? [];
      tableList = [];
      notifyListeners();
      for (var element in items) {
        tableList.add(TableModel.fromJson(element));
      }
    } catch (e) {
      Functions.showSnackBar(context, "Something went wrong");
    }
    isTableLoading = false;
    notifyListeners();
  }

  void selectRestaurant(RestaurantModel model, BuildContext context) {
    selectedRestaurant = model;
    selectedTable = null;
    selectedHall = null;
    tableList = [];
    halllList = [];
    notifyListeners();
    if (isTakeAway) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SelectMenu(
            resId: model.resId?.toInt() ?? 0,
            tableNo: null,
            isTakeAway: true,
          ),
        ),
      );
      return;
    }
    getHalls(context);
    // tables will be call after hall selection
   // getTables(context);

  }
//for selected hall
  void selectHall(Hall model, BuildContext context) {
    selectedHall = model;
    notifyListeners();
    debugPrint("Hall ${selectedHall?.hall}");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => SelectMenu(
    //       resId: selectedRestaurant?.resId?.toInt() ?? 0,
    //       tableNo: selectedTable?.tableNo1 ?? "",
    //       isTakeAway: isTakeAway,
    //     ),
    //   ),
    // );
    getTables(context);
  }
  void selectTable(TableModel model, BuildContext context) {
    selectedTable = model;
    debugPrint(model.toString());
    notifyListeners();
    debugPrint("table ${selectedTable?.tableNo1}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectMenu(
          resId: selectedRestaurant?.resId?.toInt() ?? 0,
          tableNo: selectedTable?.tableNo1 ?? "",
          isTakeAway: isTakeAway,
        ),
      ),
    );
  }
}

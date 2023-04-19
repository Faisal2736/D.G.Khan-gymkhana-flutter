import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gymkhana_club/extras/fucntions.dart';
import 'package:gymkhana_club/shared/service.dart';

import '../models/restaurant_model.dart';

class TableReservationProvider extends ChangeNotifier {
  var toDate = TextEditingController();
  var fromDate = TextEditingController();
  var restu = TextEditingController();
  var persons = TextEditingController();
  var remarks = TextEditingController();
  List<RestaurantModel> restaurantList = [];

  RestaurantModel? selectedRestaurant;

  void selectRestaurant(RestaurantModel model) {
    selectedRestaurant = model;
    notifyListeners();
  }

  TableReservationProvider() {
    getRestaurants();
  }

  final ApiService _apiService = ApiService();

  bool isLoading = true;

  Future<void> getRestaurants() async {
    try {
      debugPrint("here");
      var response = await _apiService
          .get("FoodOrdering/GetRestaurantList?Takeaway=false");
      var body = jsonDecode(response.body);
      List items = body["restaurantList"] ?? [];
      for (var item in items) {
        restaurantList.add(RestaurantModel.fromJson(item));
      }
      if (restaurantList.isNotEmpty) {
        selectedRestaurant = restaurantList.first;
      }
      debugPrint(response.body.toString());
    } catch (e) {
      debugPrint(e.toString());
      // TODO
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> reserveTable(BuildContext context, String memberId) async {
    if (toDate.text.trim().isEmpty ||
        fromDate.text.trim().isEmpty ||
        persons.text.trim().isEmpty) {
      Functions.showSnackBar(context, "All fields are required");
      return;
    }

    Functions.showLoaderDialog(context);
    try {
      var url = "Reservations/TableReservation";
      var body = {
        "id": 0,
        "memberid": memberId,
        "cdate": toDate.text.trim(),
        "ctime": fromDate.text.trim(),
        "noPerson": int.tryParse(persons.text.trim()) ?? 0,
        "remarks": remarks.text.trim(),
        "resturant": selectedRestaurant?.name ?? ""
      };
      debugPrint(body.toString());
      var response = await _apiService.post(url, body);
      debugPrint("table reservation response : ${response.body}");
      Navigator.of(context).pop();
      Functions.showSnackBar(context, "Table reservation successful");
      Navigator.of(context).pop();
      return;
    } catch (e) {
      debugPrint("table reservation : ${e.toString()}");
      // TODO
    }
    Navigator.of(context).pop();
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymkhana_club/extras/fucntions.dart';
import 'package:gymkhana_club/screens/profile/homepage.dart';
import 'package:gymkhana_club/shared/providers/data_provider.dart';
import 'package:gymkhana_club/shared/service.dart';
import 'package:provider/provider.dart';

import '../models/cart_details_model.dart';
import '../models/cart_items_model.dart';

class CartMenuProvider extends ChangeNotifier {
  int resId;
  String? tableNo;
  bool isTakeAway;
  BuildContext context;

  CartMenuProvider(
      {required this.resId,
        required this.isTakeAway,
        required this.context,
        required this.tableNo}) {
    getCartItems();
  }

  final ApiService _apiService = ApiService();

  List<CartItemsModel> cartItems = [];
  CartDetailsModel? cartDetailsModel;
  bool isLoading = true;

  Future<void> getCartItems() async {
    final memberId = context.read<DataProvider>().memberId;
    var url =
        "Cart/GetCart?memberId=$memberId&resId=$resId&takeaway=$isTakeAway";
    debugPrint(url);
    try {
      var response = await _apiService.get(url);
      var responseBody = jsonDecode(response.body);
      cartDetailsModel = CartDetailsModel.fromJson(responseBody["cartview"]);
      List items = responseBody["cartList"] ?? [];
      cartItems = List.generate(
          items.length, (index) => CartItemsModel.fromJson(items[index]));
    } catch (e) {}
    isLoading = false;
    notifyListeners();
  }

  Future<void> decrementCartItem(CartItemsModel model) async {
    if (((model.qty?.toInt() ?? 1) - 1) < 1) {
      return;
    }
    var url = "Cart/UpdateCart";
    Functions.showLoaderDialog(context);
    try {
      var body = {
        "id": model.id,
        "itemId": model.itemId,
        "isize": model.isize,
        "qty": (model.qty?.toInt() ?? 1) - 1,
        "sessionId": model.sessionId,
        "orderDate": model.orderDate,
        "memberId": model.memberId,
        "createdAt": model.createdAt,
        "updatedAt": model.updatedAt,
        "amount": model.amount,
        "unitPrice": model.unitPrice,
        "tableNo": model.tableNo,
        "resId": model.resId,
        "remarks": model.remarks
      };
      await _apiService.put(url, body);
      model.qty = (model.qty?.toInt() ?? 1) - 1;

      num total = (model.qty ?.toDouble() ?? 0) *
          (model.unitPrice?.toDouble() ?? 0);
      model.amount = total ;

    } catch (e) {}
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future<void> incrementCartItem(CartItemsModel model) async {
    var url = "Cart/UpdateCart";
    Functions.showLoaderDialog(context);
    try {
      var body = {
        "id": model.id,
        "itemId": model.itemId,
        "isize": model.isize,
        "qty": (model.qty?.toInt() ?? 1) + 1,
        "sessionId": model.sessionId,
        "orderDate": model.orderDate,
        "memberId": model.memberId,
        "createdAt": model.createdAt,
        "updatedAt": model.updatedAt,
        "amount": model.amount,
        "unitPrice": model.unitPrice,
        "tableNo": model.tableNo,
        "resId": model.resId,
        "remarks": model.remarks
      };
      await _apiService.put(url, body);
      model.qty = (model.qty?.toInt() ?? 1) + 1;

      num total = (model.qty ?.toDouble() ?? 0) *
          (model.unitPrice?.toDouble() ?? 0);

      model.amount = total ;
      debugPrint(model.qty.toString());
      debugPrint(model.amount.toString());
    } catch (e) {}
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future<void> removeCartItem(CartItemsModel model) async {
    var url = "Cart/RemoveCartItem?id=${model.id}";
    Functions.showLoaderDialog(context);
    try {
      await _apiService.delete(url);
      cartItems.removeWhere((element) => element.id == model.id);
    } catch (e) {}
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future<void> placeOrder(num balance , num limit) async {
    debugPrint(cartDetailsModel.toString());
    if (cartItems.isEmpty) {
      Functions.showSnackBar(context, "Cart is Empty");
      return;
    }
    if (balance<0 ) {
      Functions.showSnackBar(context, " Available Limit $balance" + "");
      return;
    }

    var url = "FoodOrdering/AddOrder";
    var body = {};
    body.addAll(cartDetailsModel?.toJson() ?? {});
    body.addAll(
        {"detailInput": cartItems.map((e) => e.toJson()).toSet().toList()});
    body["isTakeAway"] = isTakeAway;
    if ((tableNo?.isNotEmpty ?? false) && !isTakeAway) {
      body["tableNo"] =tableNo;
    }
    else if( isTakeAway ){
      body.remove("tableNo");
    }
    log(body.toString());
    Functions.showLoaderDialog(context);
    try {
      await _apiService.post(url, body);
      await clearCart();
      Navigator.of(context).pop();
      Functions.showSnackBar(context, "Order placed Successfuly");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Homepage(),
          ),
              (route) => false);
      return;
    } catch (e) {
      Functions.showSnackBar(context, "Something went wrong");
      // TODO
    }
    Navigator.of(context).pop();
  }

  Future<void> clearCart() async {
    var url =
        "Cart/ClearCart?memberId=${cartDetailsModel?.customerId}&tableNo=${cartDetailsModel?.tableNo}&resId=${cartDetailsModel?.resId}";
    var response = await _apiService.delete(url);
  }


}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gymkhana_club/extras/fucntions.dart';
import 'package:gymkhana_club/shared/providers/data_provider.dart';
import 'package:provider/provider.dart';

import '../models/menu_item_model.dart';
import '../models/menu_model.dart';
import '../service.dart';

class MenuViewProvider extends ChangeNotifier {
  List<MenuModel> menuList = [];
  int cartNumber = 0;
  final ApiService _apiService = ApiService();
  late int resId;
  late String? tableNo;
  late BuildContext context;
  MenuModel? selectedMenu;
  final node = FocusNode();
  final controller = TextEditingController();
  bool isTakeAway;

  MenuViewProvider(
      {required this.resId,
      required this.context,
      required this.tableNo,
      required this.isTakeAway}) {
    getMenuList();
  }


  List<MenuItemModel> menuItemsList = [];

  bool isLoading = true;

  Future<void> getMenuList() async {
    var url = "FoodOrdering/GetMainHeadList";
    var body = {"resId": resId, "menuid": 4};
    try {
      var response = await _apiService.post(url, body);
      var responseBody = jsonDecode(response.body);
      List items = responseBody["mainHeadList"];
      for (var element in items) {
        menuList.add(MenuModel.fromJson(element));
      }
    } catch (e) {
      Functions.showSnackBar(context, "Something went wrong");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getMenuItems() async {
    var url = "FoodOrdering/GetMenuItemsList";
    var body = {
      "resId": resId,
      "menuId": 4,
      "menuHeadId": selectedMenu?.mainHead ?? ""
    };
    isItemsLoading = true;
    controller.clear();
    node.unfocus();
    notifyListeners();
    try {
      var response = await _apiService.post(url, body);
      var responseBody = jsonDecode(response.body);
      List items = responseBody["menuItemList"] ?? [];
      menuItemsList = [];
      for (var element in items) {
        menuItemsList.add(MenuItemModel.fromJson(element));
      }
    } catch (e) {
      Functions.showSnackBar(context, "Something went wrong");
    }
    isItemsLoading = false;
    notifyListeners();
  }

  void selectMenu(MenuModel model) {
    selectedMenu = model;
    menuItemsList = [];
    notifyListeners();
    getMenuItems();
  }

  void addToCard(MenuItemModel menuItemsList, String size, int quantity,
      double price, String remarks) async {
    if (quantity < 1) {
      Functions.showSnackBar(context, "Please Add some quantity");
      return;
    }

    var url = "Cart/AddToCart";
    final memberId = context.read<DataProvider>().memberId;
    var body = {
      "itemId": menuItemsList.code,
      "isize": size,
      "qty": quantity,
      // "memberId": "01-000002-00",
      "memberId": memberId,
      "amount": quantity * price,
      "unitPrice": price,
      "resId": resId,
      "isCartadded": true,
      "remarks": remarks,
      "isTakeAway": isTakeAway,
    };
    debugPrint(body.toString());
    Functions.showLoaderDialog(context);
    try {
      var response = await _apiService.post(url, body);
      cartNumber++;
      Functions.showSnackBar(context, "Item added");
    } on Exception catch (e) {
      // TODO
      Functions.showSnackBar(context, "Something went wrong");
    }
    Navigator.of(context).pop();
    notifyListeners();
  }

  bool isItemsLoading = false;

  Future<void> searchMenu() async {
    var text = controller.text.trim();
    if (text.isEmpty) {
      return;
    }
    selectedMenu = null;
    menuItemsList = [];
    isItemsLoading = true;
    node.unfocus();
    notifyListeners();

    var url = "FoodOrdering/GetSearchMenuItemsList";
    var body = {"resId": resId, "filter": text};
    try {
      var response = await _apiService.post(url, body);
      var responseBody = jsonDecode(response.body);
      List items = responseBody["menuItemList"] ?? [];
      menuItemsList = [];
      for (var element in items) {
        menuItemsList.add(MenuItemModel.fromJson(element));
      }
    } catch (e) {
      Functions.showSnackBar(context, "Something went wrong");
    }
    isItemsLoading = false;
    notifyListeners();
  }
}

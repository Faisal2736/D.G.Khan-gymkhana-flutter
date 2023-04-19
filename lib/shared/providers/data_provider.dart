import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymkhana_club/shared/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../extras/fucntions.dart';
import '../../screens/profile/homepage.dart';
import '../models/epool_model.dart';
import '../models/user_model.dart';

class DataProvider extends ChangeNotifier {
  late UserModel userModel  ;
  UserModel? model;
  bool dataFetched = false;
  late String memberId;
  final ApiService _apiService = ApiService();
  List<String> promotionImages = [];





  Future<void> getUserModel(BuildContext context, String memberId,
      {bool showLoading = true, bool isLogin = true}) async {
    if (showLoading) {
      Functions.showLoaderDialog(context);
    }
    final prefs = await SharedPreferences.getInstance();
    try {
      //  await getEpoolMode();
      this.memberId = memberId;
      var url = "Account/GetMemberProfile?memberId=$memberId";
      var response = await _apiService.get(url);
      await getPromotions();
      if (isLogin) {
        await updateDevice(memberId);
      }
      var responseBody = jsonDecode(response.body);
      var result = responseBody["result"];
      userModel = UserModel.fromJson(result);
      model = userModel;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("memberId", memberId);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Homepage(),
          ),
              (route) => false);
      return;
    } catch (e) {
      prefs.setString("memberId", "");
      // TODO
    }
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
    Functions.showSnackBar(context, "Something went wrong");


  }

  Future<void> getPromotions() async {
    var promotionApiUrl = "Account/GetPremonitions";
    var response = await _apiService.get(promotionApiUrl);
    var responseBody = jsonDecode(response.body);
    List images = responseBody["result"];
    promotionImages = [];
    for (var element in images) {
      promotionImages.add(element);
    }
  }

  Future<void> updateDevice(String memberId) async {
    var deviceData = <String, dynamic>{};
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    // var deviceId = await getUniqueDeviceId();
    var deviceId = await FirebaseMessaging.instance.getToken();;
    final token = await FirebaseMessaging.instance.getToken();
    var deviceType = Platform.isAndroid ? "Android" : "IOS";
    debugPrint("deviceId : ${deviceId} ${deviceType}");
    var url =
        "Account/UpdateDevice?memberId=$memberId&DeviceId=$deviceId&DeviceType=$deviceType";
    await _apiService.postV2(url, {});
    // await _apiService.post(url,
    //     {"memberId": memberId, "DeviceId": deviceId, "DeviceType": deviceType});
  }

  Future<String> getUniqueDeviceId() async {
    String uniqueDeviceId = '';
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      uniqueDeviceId =
      '${iosDeviceInfo.name}:${iosDeviceInfo.identifierForVendor}'; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      uniqueDeviceId =
      '${androidDeviceInfo.model}:${androidDeviceInfo.id}'; // unique ID on Android
    }

    return uniqueDeviceId;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
      ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}

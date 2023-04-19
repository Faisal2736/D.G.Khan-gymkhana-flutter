import 'package:flutter/material.dart';
import 'package:gymkhana_club/prayer_module/services/networking.dart';

const apiUrl = "http://api.aladhan.com/v1/timingsByCity";

class PrayerModel {

  Future<dynamic> getCityPrayers(String cityName) async {
    cityName = cityName.trim();
    String  country ="pakistan" ;
    String  method = "8";
    if(cityName.contains(" ")) {
      cityName = cityName.replaceAll(new RegExp(r' '), "-");
    }
    var url = "$apiUrl?city=$cityName&country=$country&method=$method";
    debugPrint("$url");
    debugPrint("getting prayer timings of $cityName");
    var url1 = Uri.parse(url);
    NetworkHelper networkHelper = NetworkHelper(url1);
    var prayersData = await networkHelper.getData();


    return prayersData;
  }

}
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gymkhana_club/prayer_module/services/prayer.dart';
import 'package:gymkhana_club/prayer_module/utilis/constants.dart';

import '../../extras/fucntions.dart';
import '../../location.dart';
import 'adhanscreen.dart';

class LoadingScreen extends StatefulWidget {
  final String cityName;

  LoadingScreen({required this.cityName});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData("Gujrat");
  }

  void getLocationData(String cityName) async {
    var city = cityName;
    try {
      final userLocation = UserLocation();
      await userLocation.determinePosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
          userLocation.latitude ?? 37, userLocation.longitude ?? 97);
      if (placemarks.isNotEmpty) {
        city = placemarks.first.locality ?? city;
        debugPrint("city name : ${city}");
      }
    } catch (e) {
      Functions.showSnackBar(context, "Unable to fetch current location");
      // TODO
    }
    PrayerModel prayerModel = PrayerModel();
    var timesData = await prayerModel.getCityPrayers(city);
    print(timesData);
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return TimesPage(
            timesData: timesData,
            cityName: city,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [color1, color1])),
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
          // child: SpinKitDoubleBounce(
          //   color: Colors.white,
          //   size: 80.0,
          // ),
        ),
      ),
    );
  }
}

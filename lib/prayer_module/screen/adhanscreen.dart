import 'package:flutter/material.dart';
import 'package:gymkhana_club/prayer_module/components/icon_text.dart';
import 'package:gymkhana_club/prayer_module/components/waktusalat.dart';
import 'package:gymkhana_club/prayer_module/utilis/constants.dart';

class TimesPage extends StatefulWidget {
  final dynamic timesData;
  final String? cityName;

  TimesPage({this.timesData, this.cityName});

  @override
  _TimesPageState createState() => _TimesPageState();
}

class _TimesPageState extends State<TimesPage> {
  String todayTime = "";
  String Fajr = "";
  String Sunrise = "";
  String Dhuhr = "";
  String Asr = "";
  String Sunset = "";
  String Maghrib = "";
  String Isha = "";
  String cityName = "";
  String Imsak = "";
  String countryName = "";
  String todayDate = "";
  dynamic data;

  @override
  void initState() {
    super.initState();
    data = widget.timesData;
    getPrayerData();
  }

  void getPrayerData() {
    setState(() {
      // todayTime = data["results"]["datetime"][0]["date"]["hijri"];
      Fajr = data["data"]["timings"]["Fajr"];
      Sunrise = data["data"]["timings"]["Sunrise"];
      Dhuhr = data["data"]["timings"]["Dhuhr"];
      Asr = data["data"]["timings"]["Asr"];
      Sunset = data["data"]["timings"]["Sunset"];
      Maghrib = data["data"]["timings"]["Maghrib"];
      Isha = data["data"]["timings"]["Isha"];
      Imsak = data["data"]["timings"]["Imsak"];
      // todayDate=data["data"]["timings"]["date"]["readable"].toString();
      //  countryName = "Gujrat";
      countryName = widget.cityName ?? "Gujrat";
      // cityName="";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [color1, color2])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/');
              //   },
              //   child: Icon(
              //     Icons.arrow_back,
              //     color: Colors.white,
              //   ),
              // ),
              // Icon(Icons.menu, color: Colors.white)
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Prayer Timings",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          Text(
            "Prayer becomes timely",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          SizedBox(
            height: 25,
          ),
          IconText(
            icon: Icon(
              Icons.location_on,
              color: Colors.white,
              size: 15,
            ),
            title: "${countryName ?? ""}",
            subTitle: "Current Location",
          ),
          SizedBox(
            height: 15,
          ),
          // SizedBox(
          //   height: 15,
          // ),
          // IconText(
          //     icon: Icon(
          //       Icons.calendar_today,
          //       color: Colors.white,
          //       size: 15,
          //     ),
          //     title: todayDate ?? "",
          //     subTitle: "Today's Date"),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: ListView(
                children: <Widget>[
                  WaktuSalat(
                    name: "Imsak",
                    time: Imsak ?? "",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  WaktuSalat(
                    name: "Fajr",
                    time: Fajr ?? "",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  WaktuSalat(
                    name: "Duhur",
                    time: Dhuhr ?? "",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  WaktuSalat(
                    name: "Asr",
                    time: Asr ?? "",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  WaktuSalat(
                    name: "Maghrib",
                    time: Maghrib ?? "",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  WaktuSalat(
                    name: "Isha",
                    time: Isha ?? "",
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }
}

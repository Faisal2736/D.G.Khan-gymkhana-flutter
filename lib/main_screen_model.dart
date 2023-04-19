import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gymkhana_club/location.dart';
import 'package:gymkhana_club/weather_api.dart';
import 'package:gymkhana_club/weather_forcast_hourly.dart';

class MainScreenModel extends ChangeNotifier {
  WeatherForecastModel? _forecastObject;

  WeatherForecastModel? get forecastObject => _forecastObject;

  bool _loading = true;

  bool get loading => _loading;
  String cityName = '';

  MainScreenModel() {
    setup();
  }

  Future<void> setup() async {
    var cityName = "Gujrat";
    try {
      final userLocation = UserLocation();
      await userLocation.determinePosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
          userLocation.latitude ?? 37, userLocation.longitude ?? 97);
      if (placemarks.isNotEmpty) {
        cityName = placemarks.first.locality ?? cityName;
      }
    } catch (e) {
      // TODO
    }
    // _forecastObject ??=
    //     await WeatherApi().fetchWeatherForecast(cityName: 'Gujrat');
    _forecastObject ??=
        await WeatherApi().fetchWeatherForecast(cityName: cityName);
    updateState();
  }

  void onSubmitLocate() async {
    updateState();
    _forecastObject = await WeatherApi().fetchWeatherForecast();
    cityName = _forecastObject!.location!.name!;
    updateState();
  }

  void onSubmitSearch() async {
    if (cityName.isEmpty) return;
    updateState();
    _forecastObject =
        await WeatherApi().fetchWeatherForecast(cityName: cityName);
    cityName = '';
    updateState();
  }

  void updateState() {
    _loading = !_loading;

    notifyListeners();
  }
}

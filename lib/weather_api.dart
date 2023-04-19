import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:gymkhana_club/weather_forcast_hourly.dart';
import 'package:gymkhana_club/constants.dart';
import 'package:gymkhana_club/location.dart';



class WeatherApi {
  final _client = HttpClient();

  static const _host = OtherConstants.WEATHER_BASE_SCHEME + OtherConstants.WEATHER_BASE_URL_DOMAIN;

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<WeatherForecastModel> fetchWeatherForecast(
      {String? cityName}) async {

    Map<String, String> parameters;

    if (cityName!=null && cityName.isNotEmpty) {
      parameters = {
        'key': OtherConstants.WEATHER_APP_ID,
        'q': cityName,
        'days': '1',
      };
    } else {
      UserLocation location = UserLocation();
      await location.determinePosition();
      String fullLocation = '${location.latitude},${location.longitude}';
      parameters = {
        'key': OtherConstants.WEATHER_APP_ID,
        'q': fullLocation,
        'days': '1',
      };
    }

    final url = _makeUri(OtherConstants.WEATHER_FORECAST_PATH, parameters);

    log('request: ${url.toString()}');
    final request = await _client.getUrl(url);
    final response = await request.close();
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((val) => jsonDecode(val)) as Map<String, dynamic>;
    return WeatherForecastModel.fromJson(json);
  }
}
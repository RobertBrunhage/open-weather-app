import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_app/models/open_weather.dart';
import 'package:open_weather_app/utils/validate_response.dart';

abstract class Api {}

abstract class BaseWeatherApi implements Api {
  Future<OpenWeather> fetchWeatherFromCity(String city);
}

class WeatherApi implements BaseWeatherApi {
  String _apiKey;

  WeatherApi() {
    _apiKey = DotEnv().env['OPEN_WEATHER_API_KEY'];
  }

  @override
  Future<OpenWeather> fetchWeatherFromCity(String city) async {
    var response = await http.get(
      Uri.encodeFull("https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&APPID=$_apiKey"),
      headers: {"Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> weatherJson = json.decode(response.body);
      var weather = OpenWeather.fromJson(weatherJson);
      return weather;
    } else {
      throw ValidateResponse.generateException(response);
    }
  }
}

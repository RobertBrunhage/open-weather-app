import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_app/models/weather.dart';

abstract class BaseWeatherApi {
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

    // status code 200 means that we made a successful get
    if (response.statusCode == 200) {
      Map<String, dynamic> weatherJson = json.decode(response.body);
      var weather = OpenWeather.fromJson(weatherJson);
      print(weather.main.temp);
      return weather;
    } else {
      print('failed getting the data');
      throw Exception();
    }
  }
}

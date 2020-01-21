import 'package:open_weather_app/models/open_weather.dart';

class OpenWeatherView {
  OpenWeatherView(OpenWeather openWeather) {
    temperature = '${openWeather?.main?.temp} °C';
  }

  String temperature;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OpenWeatherView && runtimeType == other.runtimeType && temperature == other.temperature;

  @override
  int get hashCode => temperature.hashCode;
}

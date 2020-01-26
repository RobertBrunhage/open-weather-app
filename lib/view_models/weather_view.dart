import 'package:open_weather_app/models/open_weather.dart';

class OpenWeatherView {
  OpenWeatherView(OpenWeather openWeather) {
    temperature = openWeather?.main?.temp;
    celcius = '${openWeather?.main?.temp}°C';
    farenheit = '${((openWeather?.main?.temp ?? 0) * 9 / 5 + 32).toStringAsPrecision(4)}°F';
  }

  double temperature;
  String celcius;
  String farenheit;

  String generateText() {
    final temp = temperature;
    if (temp < 0) {
      return "It's cold :)";
    } else if (temp == 0) {
      return "It's the magical ZERO";
    } else if (temp > 0 && temp < 15) {
      return "It's creeping up";
    } else {
      return "It's hot outside now :))";
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OpenWeatherView && runtimeType == other.runtimeType && temperature == other.temperature;

  @override
  int get hashCode => temperature.hashCode;
}

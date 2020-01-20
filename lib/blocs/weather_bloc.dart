import 'package:open_weather_app/models/weather.dart';
import 'package:open_weather_app/services/weather_api.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseWeatherBloc {
  void fetchWeatherFromCity(String city);

  ValueStream<OpenWeather> get weatherObservable;

  void dispose();
}

class WeatherBloc implements BaseWeatherBloc {
  WeatherBloc(BaseWeatherApi weatherApi) {
    this._weatherApi = weatherApi;
  }

  WeatherApi _weatherApi;

  BehaviorSubject<OpenWeather> _weatherSubject = BehaviorSubject<OpenWeather>();
  ValueStream<OpenWeather> get weatherObservable => _weatherSubject.stream;

  @override
  void fetchWeatherFromCity(String city) async {
    try {
      var openWeather = await _weatherApi.fetchWeatherFromCity(city);
      _weatherSubject.sink.add(openWeather);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _weatherSubject.close();
  }
}

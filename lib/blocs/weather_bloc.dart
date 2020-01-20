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

  BaseWeatherApi _weatherApi;

  BehaviorSubject<OpenWeather> _weatherSubject = BehaviorSubject<OpenWeather>();
  ValueStream<OpenWeather> get weatherObservable => _weatherSubject.stream;

  @override
  Future<void> fetchWeatherFromCity(String city) async {
    try {
      var openWeather = await _weatherApi.fetchWeatherFromCity(city);
      _weatherSubject.sink.add(openWeather);
    } catch (e) {
      _weatherSubject.sink.addError(e);
    }
  }

  @override
  void dispose() {
    _weatherSubject.close();
  }
}

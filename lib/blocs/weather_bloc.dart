import 'package:open_weather_app/models/weather.dart';
import 'package:open_weather_app/services/weather_api.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlocBase {
  void dispose();
}

abstract class BaseWeatherBloc implements BlocBase {
  void fetchWeatherFromCity(String city);

  ValueStream<OpenWeather> get weatherObservable;
}

class WeatherBloc implements BaseWeatherBloc, BlocBase {
  WeatherApi _weatherApi;
  BehaviorSubject<OpenWeather> _weatherSubject;

  WeatherBloc(BaseWeatherApi weatherApi) {
    this._weatherApi = weatherApi;

    _weatherSubject = BehaviorSubject<OpenWeather>();
  }

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

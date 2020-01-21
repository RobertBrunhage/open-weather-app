import 'package:open_weather_app/services/weather_api.dart';
import 'package:open_weather_app/view_models/weather_view.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseWeatherBloc {
  void fetchWeatherFromCity(String city);

  ValueStream<OpenWeatherView> get weatherObservable;

  void dispose();
}

class WeatherBloc implements BaseWeatherBloc {
  WeatherBloc(BaseWeatherApi weatherApi) {
    this._weatherApi = weatherApi;
  }

  BaseWeatherApi _weatherApi;

  BehaviorSubject<OpenWeatherView> _weatherSubject = BehaviorSubject<OpenWeatherView>();
  ValueStream<OpenWeatherView> get weatherObservable => _weatherSubject.stream;

  @override
  Future<void> fetchWeatherFromCity(String city) async {
    try {
      var openWeather = await _weatherApi.fetchWeatherFromCity(city);
      _weatherSubject.sink.add(OpenWeatherView(openWeather));
    } catch (e) {
      _weatherSubject.sink.addError(e);
    }
  }

  @override
  void dispose() {
    _weatherSubject.close();
  }
}

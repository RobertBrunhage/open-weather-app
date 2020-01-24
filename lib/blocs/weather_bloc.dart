import 'package:open_weather_app/models/server_response.dart';
import 'package:open_weather_app/services/weather_api.dart';
import 'package:open_weather_app/view_models/weather_view.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseWeatherBloc {
  void fetchWeatherFromCity(String city);
  void onSearch(String word);

  ValueStream<OpenWeatherView> get weatherObservable;

  void dispose();
}

class WeatherBloc implements BaseWeatherBloc {
  WeatherBloc(BaseWeatherApi weatherApi) {
    this._weatherApi = weatherApi;

    _searchObservable.distinct().debounceTime(const Duration(milliseconds: 500)).listen((term) {
      fetchWeatherFromCity(term);
    });
  }

  BaseWeatherApi _weatherApi;

  BehaviorSubject<OpenWeatherView> _weatherSubject = BehaviorSubject<OpenWeatherView>();
  ValueStream<OpenWeatherView> get weatherObservable => _weatherSubject.stream;

  BehaviorSubject<String> _searchSubject = BehaviorSubject<String>();
  ValueStream<String> get _searchObservable => _searchSubject.stream;

  @override
  Future<void> fetchWeatherFromCity(String city) async {
    print(city);
    try {
      var openWeather = await _weatherApi.fetchWeatherFromCity(city);
      _weatherSubject.sink.add(OpenWeatherView(openWeather));
    } on ServerResponse catch (e) {
      print("Something went wrong: $e");
    } catch (e) {
      print("Something went wrong: $e");
    }
  }

  @override
  void onSearch(String term) {
    _searchSubject.sink.add(term);
  }

  @override
  void dispose() {
    _weatherSubject.close();
    _searchSubject.close();
  }
}

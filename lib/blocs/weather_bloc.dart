import 'package:open_weather_app/models/open_weather.dart';
import 'package:open_weather_app/models/server_response.dart';
import 'package:open_weather_app/services/weather_api.dart';
import 'package:open_weather_app/view_models/weather_view.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseWeatherBloc {
  void fetchWeatherFromCity(String city);
  void onSearch(String word);

  ValueStream<OpenWeatherView> get weatherObservable;
  ValueStream<bool> get isLoadingObservable;

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

  BehaviorSubject<OpenWeather> _weatherSubject = BehaviorSubject<OpenWeather>();
  ValueStream<OpenWeatherView> get weatherObservable =>
      _weatherSubject.stream.map((weather) => OpenWeatherView(weather)).shareValue();

  BehaviorSubject<String> _searchSubject = BehaviorSubject<String>();
  ValueStream<String> get _searchObservable => _searchSubject.stream;

  BehaviorSubject<bool> _isLoadingSubject = BehaviorSubject<bool>().shareValueSeeded(false);
  ValueStream<bool> get isLoadingObservable => _isLoadingSubject.stream;

  @override
  Future<void> fetchWeatherFromCity(String city) async {
    _isLoadingSubject.sink.add(true);
    try {
      var openWeather = await _weatherApi.fetchWeatherFromCity(city);
      _weatherSubject.sink.add(openWeather);
    } on ServerResponse catch (serverResponse) {
      print("ServerResponse: ${serverResponse.message}");
    } catch (e) {
      print("${e.message}");
    }
    _isLoadingSubject.sink.add(false);
  }

  @override
  void onSearch(String term) {
    _searchSubject.sink.add(term);
  }

  @override
  void dispose() {
    _weatherSubject.close();
    _searchSubject.close();
    _isLoadingSubject.close();
  }
}

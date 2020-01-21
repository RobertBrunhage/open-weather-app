// Import the test package and Counter class
import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_weather_app/blocs/weather_bloc.dart';
import 'package:open_weather_app/models/open_weather.dart';
import 'package:open_weather_app/services/weather_api.dart';
import 'package:open_weather_app/view_models/weather_view.dart';

class MockWeatherApi extends Mock implements BaseWeatherApi {}

class MockOpenWeather extends Mock implements OpenWeather {}

void main() {
  test('GIVEN city name WHEN fetchWeatherFromCity is called THEN emit OpenWeather', () async {
    // ARRANGE
    final weatherApi = MockWeatherApi();
    final mockOpenWeather = MockOpenWeather();

    final weatherBloc = WeatherBloc(weatherApi);
    final expected = OpenWeatherView(mockOpenWeather);

    when(weatherApi.fetchWeatherFromCity("")).thenAnswer((_) => Future.value(mockOpenWeather));

    //ACT
    scheduleMicrotask(() {
      weatherBloc.fetchWeatherFromCity("");
    });

    //VERIFY
    expect(weatherBloc.weatherObservable, emits(expected));
  });

  test('GIVEN empty name WHEN fetchWeatherFromCity is called THEN emit error', () async {
    // ARRANGE
    final weatherApi = MockWeatherApi();
    final bloc = WeatherBloc(weatherApi);

    when(weatherApi.fetchWeatherFromCity("")).thenThrow(HttpException('Failed getting the data'));

    //ACT
    scheduleMicrotask(() {
      bloc.fetchWeatherFromCity("");
    });

    //VERIFY
    expect(bloc.weatherObservable, emitsError(isException));
  });
}

// Import the test package and Counter class
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_weather_app/blocs/weather_bloc.dart';
import 'package:open_weather_app/models/weather.dart';
import 'package:open_weather_app/services/weather_api.dart';

class MockWeatherApi extends Mock implements BaseWeatherApi {}

class MockOpenWeather extends Mock implements OpenWeather {}

void main() {
  test('GIVEN city name WHEN fetchWeatherFromCity is called THEN emit OpenWeather', () async {
    // ARRANGE
    final weatherApi = MockWeatherApi();
    final expected = MockOpenWeather();
    final bloc = WeatherBloc(weatherApi);

    when(weatherApi.fetchWeatherFromCity("")).thenAnswer((_) => Future.value(expected));

    //ACT
    await bloc.fetchWeatherFromCity("");

    //VERIFY
    expectLater(bloc.weatherObservable, emits(expected));
  });

  test('GIVEN empty name WHEN fetchWeatherFromCity is called THEN emit error', () async {
    // ARRANGE
    final weatherApi = MockWeatherApi();
    final bloc = WeatherBloc(weatherApi);

    when(weatherApi.fetchWeatherFromCity("")).thenThrow(HttpException('Failed getting the data'));

    //ACT
    await bloc.fetchWeatherFromCity("");

    //VERIFY
    await expectLater(bloc.weatherObservable, emitsError(isException));
  });
}

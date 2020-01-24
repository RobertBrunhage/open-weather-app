import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_weather_app/blocs/weather_bloc.dart';
import 'package:open_weather_app/models/open_weather.dart';
import 'package:open_weather_app/models/server_response.dart';
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

    //ASSERT
    expect(weatherBloc.weatherObservable, emits(expected));
  });

  test('GIVEN empty name WHEN fetchWeatherFromCity is called THEN emit nothing', () async {
    // ARRANGE
    final weatherApi = MockWeatherApi();
    final bloc = WeatherBloc(weatherApi);

    when(weatherApi.fetchWeatherFromCity("")).thenThrow(ServerResponse("", "", ""));

    //ACT
    scheduleMicrotask(() {
      bloc.fetchWeatherFromCity("");
    });

    //ASSERT
    expect(bloc.weatherObservable, emitsInOrder([]));
  });
}

import 'package:flutter/material.dart';
import 'package:open_weather_app/view_models/weather_view.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({
    Key key,
    @required this.openWeather,
  }) : super(key: key);

  final OpenWeatherView openWeather;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        '${openWeather.temperature}',
        style: Theme.of(context).textTheme.display4,
      ),
    );
  }
}

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
      child: Container(
        width: 800,
        height: 340,
        child: Card(
          elevation: 18,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '${openWeather.celcius}',
                          style: Theme.of(context).textTheme.display4,
                        ),
                        Text(
                          '${openWeather.farenheit}',
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ],
                    ),
                    Icon(
                      Icons.wb_sunny,
                      size: 112,
                      color: Colors.yellow,
                    ),
                  ],
                ),
                Text(
                  '${openWeather.generateText()}',
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

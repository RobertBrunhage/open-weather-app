import 'package:flutter/material.dart';
import 'package:open_weather_app/ui/pages/home/widgets/rotating_snowflake.dart';
import 'package:open_weather_app/ui/pages/home/widgets/rotating_sun.dart';
import 'package:open_weather_app/view_models/weather_view.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({
    Key key,
    @required this.openWeather,
  }) : super(key: key);

  final OpenWeatherView openWeather;

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: 740,
        height: 340,
        child: Card(
          elevation: 18,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 84,
              vertical: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '${widget.openWeather.celcius}',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          '${widget.openWeather.farenheit}',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    if (widget.openWeather.temperature < 5) RotatingSnowflake() else RotatingSun()
                  ],
                ),
                Text(
                  '${widget.openWeather.generateText()}',
                  style: Theme.of(context).textTheme.headline6.copyWith(
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

import 'package:flutter/material.dart';
import 'package:open_weather_app/blocs/weather_bloc.dart';
import 'package:open_weather_app/ui/pages/home/widgets/current_weather.dart';
import 'package:open_weather_app/ui/pages/home/widgets/weather_search_field.dart';
import 'package:open_weather_app/view_models/weather_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BaseWeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();

    _weatherBloc = Provider.of<BaseWeatherBloc>(context, listen: false);
    _weatherBloc.fetchWeatherFromCity("Gothenburg");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 200),
            WeatherSearchField(),
            SizedBox(height: 150),
            StreamBuilder<OpenWeatherView>(
              stream: _weatherBloc.weatherObservable,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final openWeather = snapshot.data;
                  return CurrentWeather(openWeather: openWeather);
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

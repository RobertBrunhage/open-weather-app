import 'package:flutter/material.dart';
import 'package:open_weather_app/blocs/weather_bloc.dart';
import 'package:open_weather_app/view_models/weather_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

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
        child: StreamBuilder<OpenWeatherView>(
          stream: _weatherBloc.weatherObservable,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return SizedBox();
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return SizedBox();
                } else {
                  final openWeather = snapshot.data;
                  return CurrentWeather(openWeather: openWeather);
                }
            }
          },
        ),
      ),
    );
  }
}

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({
    Key key,
    @required this.openWeather,
  }) : super(key: key);

  final OpenWeatherView openWeather;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${openWeather.temperature}',
      style: Theme.of(context).textTheme.display4,
    );
  }
}

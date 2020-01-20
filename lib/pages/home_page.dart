import 'package:flutter/material.dart';
import 'package:open_weather_app/blocs/weather_bloc.dart';
import 'package:open_weather_app/models/weather.dart';
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<OpenWeather>(
          stream: _weatherBloc.weatherObservable,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final openWeather = snapshot.data;
              return Text(
                openWeather.main.temp.toString(),
                style: Theme.of(context).textTheme.display4,
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

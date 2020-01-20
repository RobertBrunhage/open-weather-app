import 'package:flutter/material.dart';
import 'package:open_weather_app/blocs/weather_bloc.dart';
import 'package:open_weather_app/models/weather.dart';
import 'package:open_weather_app/services/service_location.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<OpenWeather>(
          stream: sl.get<BaseWeatherBloc>().weatherObservable,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data.main.temp.toString(),
                style: Theme.of(context).textTheme.display4,
              );
            }
            return Text("site");
          },
        ),
      ),
    );
  }
}

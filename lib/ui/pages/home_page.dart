import 'package:flutter/material.dart';
import 'package:open_weather_app/blocs/weather_bloc.dart';
import 'package:open_weather_app/models/server_response.dart';
import 'package:open_weather_app/ui/pages/widgets/current_weather.dart';
import 'package:open_weather_app/ui/pages/widgets/weather_search_field.dart';
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
        child: Column(
          children: <Widget>[
            SizedBox(height: 200),
            WeatherSearchField(),
            SizedBox(height: 150),
            StreamBuilder<OpenWeatherView>(
              stream: _weatherBloc.weatherObservable,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return SizedBox();
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      ServerResponse response = snapshot.error;
                      return Text(response.header);
                    } else {
                      final openWeather = snapshot.data;
                      return CurrentWeather(openWeather: openWeather);
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

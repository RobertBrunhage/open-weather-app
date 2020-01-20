import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_weather_app/pages/home_page.dart';
import 'package:open_weather_app/services/service_location.dart';

import 'blocs/weather_bloc.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  setUpServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _openWeatherBloc = sl.get<BaseWeatherBloc>();

  @override
  void initState() {
    super.initState();
    _openWeatherBloc.fetchWeatherFromCity("Gothenburg");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

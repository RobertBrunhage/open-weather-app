import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_weather_app/services/service_location.dart';

import 'blocs/weather_bloc.dart';
import 'models/weather.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  setUpServiceLocator();
  sl.get<BaseWeatherBloc>().fetchWeatherFromCity("Gothenburg");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              return Text(snapshot.data.main.temp.toString());
            }
            return Text("site");
          },
        ),
      ),
    );
  }
}

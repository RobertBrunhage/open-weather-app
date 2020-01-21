import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_weather_app/blocs/weather_bloc.dart';
import 'package:open_weather_app/services/weather_api.dart';
import 'package:open_weather_app/ui/pages/home_page.dart';
import 'package:provider/provider.dart';

class _Holder<T> {
  _Holder(this.value);

  final T value;
}

Future<void> main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<_Holder<BaseWeatherApi>>(
          create: (_) => _Holder(WeatherApi()),
        ),
        ProxyProvider<_Holder<BaseWeatherApi>, BaseWeatherBloc>(
          update: (context, weatherApiHolder, weatherBloc) => WeatherBloc(weatherApiHolder.value),
          dispose: (_, weatherBloc) => weatherBloc.dispose(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

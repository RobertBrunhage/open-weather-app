import 'package:get_it/get_it.dart';
import 'package:open_weather_app/blocs/weather_bloc.dart';
import 'package:open_weather_app/services/weather_api.dart';

GetIt sl = GetIt.instance;

void setUpServiceLocator() {
  var weatherApi = WeatherApi();

  sl.registerLazySingleton<BaseWeatherBloc>(() => WeatherBloc(weatherApi));
}

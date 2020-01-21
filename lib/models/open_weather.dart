class OpenWeather {
  _Coord coord;
  List<_Weather> weather;
  String base;
  _Main main;
  int visibility;
  _Wind wind;
  _Clouds clouds;
  int dt;
  _Sys sys;
  int id;
  String name;
  int cod;

  OpenWeather(
      {this.coord,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.id,
      this.name,
      this.cod});

  OpenWeather.fromJson(Map<String, dynamic> json) {
    coord = json['coord'] != null ? _Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = List<_Weather>();
      json['weather'].forEach((v) {
        weather.add(_Weather.fromJson(v));
      });
    }
    base = json['base'];
    main = json['main'] != null ? _Main.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? _Wind.fromJson(json['wind']) : null;
    clouds = json['clouds'] != null ? _Clouds.fromJson(json['clouds']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? _Sys.fromJson(json['sys']) : null;
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }
}

class _Coord {
  double lon;
  double lat;

  _Coord({this.lon, this.lat});

  _Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }
}

class _Weather {
  int id;
  String main;
  String description;
  String icon;

  _Weather({this.id, this.main, this.description, this.icon});

  _Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }
}

class _Main {
  double temp;
  int pressure;
  int humidity;
  double tempMin;
  double tempMax;

  _Main({this.temp, this.pressure, this.humidity, this.tempMin, this.tempMax});

  _Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
  }
}

class _Wind {
  double speed;
  int deg;

  _Wind({this.speed, this.deg});

  _Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
  }
}

class _Clouds {
  int all;

  _Clouds({this.all});

  _Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }
}

class _Sys {
  int type;
  int id;
  double message;
  String country;
  int sunrise;
  int sunset;

  _Sys({this.type, this.id, this.message, this.country, this.sunrise, this.sunset});

  _Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    message = json['message'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }
}

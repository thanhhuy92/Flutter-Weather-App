
class Coord {
  final double lon ;
  final double lat ;

  Coord(
      {
        this.lon,
        this.lat
      }
      );

  factory Coord.fromJson(Map<String, dynamic> json){
    return Coord(
        lon: double.parse(json['lon'].toString()),
        lat: double.parse(json['lat'].toString())
    );
  }
}

class Weather {
  final int id ;
  final String main ;
  final String description ;
  final String icon ;

  Weather(
      {
        this.id,
        this.main,
        this.description,
        this.icon
      }
      );

  factory Weather.fromJson(Map<String,dynamic> json){
    return Weather(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon']
    );
  }
}

class Main {
  final int temp ;
  final double pressure ;
  final int humidity ;
  final double temp_min ;
  final double temp_max ;
  final double sea_level;
  final double grnd_level;

  Main(
      {
        this.temp,
        this.pressure,
        this.humidity,
        this.temp_min,
        this.temp_max,
        this.sea_level,
        this.grnd_level
      }
      );

  factory Main.fromJson(Map<String,dynamic> json){
    return Main(
        temp: json['temp'],
        temp_min: double.parse(json['temp_min'].toString()),
        temp_max: double.parse(json['temp_max'].toString()),
        sea_level:
          json['sea_level'] == null ? 0.0 : double.parse(json['sea_level'].toString()),
        grnd_level:
          json['grnd_level'] == null ? 0.0 : double.parse(json['grnd_level'].toString()),
        pressure: double.parse(json['pressure'].toString()),
        humidity: json['humidity']
    );
  }

}

class Wind {
  final double speed ;
  final int deg ;

  Wind(
      {
        this.speed,
        this.deg
      }
      );

  factory Wind.fromJson(Map<String,dynamic> json)
  {
    return Wind(
        speed: double.parse(json['speed'].toString()),
        deg: json['deg'],
    );
  }
}

class Clouds {
  final int all ;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String,dynamic> json)
  {
    return Clouds(all: json['all']);
  }
}

class Sys {
  final String country ;
  final int sunrise ;
  final int sunset ;

  Sys({this.country, this.sunrise, this.sunset});

  factory Sys.fromJson(Map<String,dynamic> json){
    return Sys(
        country: json['country'],
        sunrise: json['sunrise'],
        sunset: json['sunset']);
  }
}

class WeatherModel {
  final Coord coord ;
  final List<Weather> weather ;
  final String base ;
  final Main main ;
  final int visibility ;
  final Wind wind ;
  final Clouds clouds ;
  final int dt ;
  final Sys sys ;
  final int timezone ;
  final int id ;
  final String name ;
  final int cod ;

  WeatherModel(
      {
        this.coord,
        this.weather,
        this.base,
        this.main,
        this.visibility,
        this.wind,
        this.clouds,
        this.dt,
        this.sys,
        this.timezone,
        this.id,
        this.name,
        this.cod});

  factory WeatherModel.fromJson(Map<String,dynamic> json)
  {
    return WeatherModel(
        coord: Coord.fromJson(json['coord']),
        weather: (json['weather'] as List).map((item)=>Weather.fromJson(item)).toList(),
        base: json['base'],
        main: Main.fromJson(json['main']),
        wind: Wind.fromJson(json['wind']),
        clouds: Clouds.fromJson(json['clouds']),
        dt: json['dt'],
        sys: Sys.fromJson(json['sys']),
        timezone: json['timezone'],
        id: json['id'],
        name: json['name'],
        cod: json['cod']
    );
  }
}
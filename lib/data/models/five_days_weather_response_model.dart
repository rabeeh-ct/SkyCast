import '../../domain/entities/five_days_weather_response_entity.dart';

class FiveDaysWeatherResponseModel extends FiveDaysWeatherResponseEntity {
  FiveDaysWeatherResponseModel({
    required super.cod,
    required super.message,
    required super.cnt,
    required super.list,
    required super.city,
  });

  factory FiveDaysWeatherResponseModel.fromJson(Map<String, dynamic> json) =>
      FiveDaysWeatherResponseModel(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list: List<ListElement>.from(json["list"].map((x) => ListElementModel.fromJson(x))),
        city: CityModel.fromJson(json["city"]),
      );
}

class CityModel extends City {
  CityModel({
    required super.id,
    required super.name,
    required super.coord,
    required super.country,
    required super.population,
    required super.timezone,
    required super.sunrise,
    required super.sunset,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        name: json["name"],
        coord: CoordModel.fromJson(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );
}

class CoordModel extends Coord {
  CoordModel({
    required super.lat,
    required super.lon,
  });

  factory CoordModel.fromJson(Map<String, dynamic> json) => CoordModel(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );
}

class ListElementModel extends ListElement {
  ListElementModel({
    required super.dt,
    required super.main,
    required super.weather,
    required super.clouds,
    required super.wind,
    required super.visibility,
    required super.pop,
    required super.sys,
    required super.dtTxt,
    super.rain,
  });

  factory ListElementModel.fromJson(Map<String, dynamic> json) => ListElementModel(
        dt: json["dt"],
        main: MainModel.fromJson(json["main"]),
        weather: List<WeatherModel>.from(json["weather"].map((x) => WeatherModel.fromJson(x))),
        clouds: CloudsModel.fromJson(json["clouds"]),
        wind: WindModel.fromJson(json["wind"]),
        visibility: json["visibility"],
        pop: json["pop"]?.toDouble(),
        sys: SysModel.fromJson(json["sys"]),
        dtTxt: DateTime.parse(json["dt_txt"]),
        rain: json["rain"] == null ? null : RainModel.fromJson(json["rain"]),
      );
}

class CloudsModel extends Clouds {
  CloudsModel({
    required super.all,
  });

  factory CloudsModel.fromJson(Map<String, dynamic> json) => CloudsModel(
        all: json["all"],
      );
}

class MainModel extends Main {
  MainModel({
    required super.temp,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.pressure,
    required super.seaLevel,
    required super.grndLevel,
    required super.humidity,
    required super.tempKf,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) => MainModel(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"]?.toDouble(),
      );
}

class RainModel extends Rain {
  RainModel({
    required super.the3H,
  });

  factory RainModel.fromJson(Map<String, dynamic> json) => RainModel(
        the3H: json["3h"]?.toDouble(),
      );
}

class SysModel extends Sys {
  SysModel({
    required super.pod,
  });

  factory SysModel.fromJson(Map<String, dynamic> json) => SysModel(
        pod: json["pod"],
      );
}

class WeatherModel extends Weather {
  WeatherModel({
    required super.id,
    required super.main,
    required super.description,
    required super.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );
}

class WindModel extends Wind {
  WindModel({
    required super.speed,
    required super.deg,
    required super.gust,
  });

  factory WindModel.fromJson(Map<String, dynamic> json) => WindModel(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
        gust: json["gust"]?.toDouble(),
      );
}

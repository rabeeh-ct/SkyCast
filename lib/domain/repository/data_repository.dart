import 'package:dartz/dartz.dart';
import 'package:sky_cast/domain/entities/geocode_entity.dart';
import 'package:sky_cast/domain/entities/weather_entity.dart';

import '../entities/app_error.dart';
import '../entities/five_days_weather_response_entity.dart';

abstract class DataRepository {

  Future<Either<AppError, WeatherEntity>> getCurrentWeather({
    Map<String, dynamic>? queryParameters});

  Future<Either<AppError, GeocodeEntity>> locationToLatLng({
    Map<String, dynamic>? queryParameters});

  Future<Either<AppError, FiveDaysWeatherResponseEntity>> getFiveDaysForecast({
    Map<String, dynamic>? queryParameters});

}

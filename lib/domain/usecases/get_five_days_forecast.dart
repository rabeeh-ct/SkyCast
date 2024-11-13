import 'package:dartz/dartz.dart';
import 'package:sky_cast/di/di.dart';
import 'package:sky_cast/domain/entities/weather_entity.dart';
import 'package:sky_cast/domain/params/no_params.dart';
import 'package:sky_cast/utils/debug_utils.dart';
import '../../common/constants.dart';
import '../entities/five_days_weather_response_entity.dart';
import '/domain/entities/app_error.dart';
import '/domain/usecases/usecase.dart';

import '../repository/data_repository.dart';

class GetFiveDaysForecastUseCase extends UseCase<FiveDaysWeatherResponseEntity, NoParams> {
  final DataRepository dataRepository = getIt.get<DataRepository>();

  @override
  Future<Either<AppError, FiveDaysWeatherResponseEntity>> call(NoParams params, {Map<String, dynamic>? queryParameters}) async {
    consoleLog(":::::::::::1");
    return await dataRepository.getFiveDaysForecast(queryParameters: queryParameters);
  }
}

class GetFiveDaysForecastQueryParams {
  final String lat;
  final String lon;
  final String appid;
  final String units;

  GetFiveDaysForecastQueryParams({
    required this.lat,
    required this.lon,
    this.units="metric",
    this.appid= apiKey,
  });

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
    "units": units,
    "appid": appid,
  };
}
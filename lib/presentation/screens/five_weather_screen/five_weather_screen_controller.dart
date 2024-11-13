import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:sky_cast/domain/entities/app_error.dart';

import '../../../di/di.dart';
import '../../../domain/entities/five_days_weather_response_entity.dart';
import '../../../domain/params/no_params.dart';
import '../../../domain/usecases/get_current_weather_usecase.dart';
import '../../../domain/usecases/get_five_days_forecast.dart';
import '../../../utils/debug_utils.dart';

class FiveWeatherScreenController extends ChangeNotifier {

  bool pageLoading = true;
  List<ListElement> fiveDaysForecast=[];

  final _getFiveDaysForecastUseCase = getIt.get<GetFiveDaysForecastUseCase>();
  AppError? appError;
  late FiveDaysWeatherResponseEntity fiveDaysWeatherResponseEntity;

  Future<void> getDailyWeather(LatLng location,BuildContext context) async {
    pageLoading = true;
    // notifyListeners();
    final GetFiveDaysForecastQueryParams queryParams = GetFiveDaysForecastQueryParams(
      lat: location.latitude.toString(), lon: location.longitude.toString(),);
    final response = await _getFiveDaysForecastUseCase(const NoParams(),
        queryParameters: queryParams.toJson());
    response.fold((l) {
      // api error handling
      appError = l;
      notifyListeners();
      return l.handleError(context: context);
    }, (r) async {
      // success data from api
      fiveDaysWeatherResponseEntity = r;
      fiveDaysForecast.clear();
      fiveDaysForecast.add(fiveDaysWeatherResponseEntity.list.first);
      for(int i=0;i<fiveDaysWeatherResponseEntity.list.length;i++){
        if(i%7==0){
          fiveDaysForecast.add(fiveDaysWeatherResponseEntity.list[i]);
        }
      }
    });
    pageLoading = false;
    consoleLog(fiveDaysForecast);
    notifyListeners();
  }

  // try {
  // final response = await http.get(dailyUrl);
  // final dailyData = json.decode(response.body) as Map<String, dynamic>;
  // additionalWeatherData = AdditionalWeatherData.fromJson(dailyData);
  // List dailyList = dailyData['daily'];
  // List hourlyList = dailyData['hourly'];
  // hourlyWeather = hourlyList
  //     .map((item) => HourlyWeather.fromJson(item))
  //     .toList()
  //     .take(24)
  //     .toList();
  // dailyWeather =
  // dailyList.map((item) => DailyWeather.fromDailyJson(item)).toList();
  // } catch
  //
  // (
  //
  // error) {
  // print(error);
  // isLoading = false;
  // this.isRequestError = true;
  // }
}


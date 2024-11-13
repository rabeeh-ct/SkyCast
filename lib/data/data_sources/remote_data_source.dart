import 'package:sky_cast/data/models/five_days_weather_response_model.dart';
import 'package:sky_cast/data/models/geocode_model.dart';
import 'package:sky_cast/data/models/weather_model.dart' as wm;

import '../../di/di.dart';
import '../../utils/debug_utils.dart';
import '../core/api_client.dart';
import '../core/api_constants.dart';

abstract class RemoteDataSource {
  // Future<AppVersionModel> appVersionCheck(Map<String, dynamic> params);

  Future<wm.WeatherModel> getCurrentWeather(
      {Map<String, dynamic>? queryParameters});

  Future<GeocodeModel> locationToLatLng(
      {Map<String, dynamic>? queryParameters});

  Future<FiveDaysWeatherResponseModel> getFiveDaysForecast(
      {Map<String, dynamic>? queryParameters});

// Future<BookingManagementResponseModel> getMyBookings(
//     Map<String, dynamic> params, {Map<String, dynamic>? queryParameters});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiClient _apiClient = getIt.get<ApiClient>();

  @override
  Future<wm.WeatherModel> getCurrentWeather(
      {Map<String, dynamic>? queryParameters}) async {
    consoleLog(":::::::::::4");
    final response = await _apiClient.get(ApiConstants.getCurrentWeather,
        params: null, queryParameters: queryParameters);
    consoleLog(":::::::::::6");
    wm.WeatherModel weatherModel;
    try {
      weatherModel = wm.WeatherModel.fromJson(response);
    } catch (e) {
      throw Exception();
    }
    return weatherModel;
  }

  @override
  Future<GeocodeModel> locationToLatLng(
      {Map<String, dynamic>? queryParameters}) async {
    consoleLog(":::::::::::4");
    final response = await _apiClient.get(ApiConstants.locationToLatLng,
        params: null, queryParameters: queryParameters);
    consoleLog(":::::::::::6");
    GeocodeModel geocodeModel;
    try {
      geocodeModel = GeocodeModel.fromJson(response[0]);
    } catch (e) {
      consoleLog(e);
      throw Exception();
    }
    return geocodeModel;
  }

  @override
  Future<FiveDaysWeatherResponseModel> getFiveDaysForecast({Map<String, dynamic>? queryParameters}) async {
    consoleLog(":::::::::::4");
    final response = await _apiClient.get(ApiConstants.fiveDaysForecast,
        params: null, queryParameters: queryParameters);
    consoleLog(":::::::::::6");
    FiveDaysWeatherResponseModel weatherModel;
    try {
      weatherModel = FiveDaysWeatherResponseModel.fromJson(response);
    } catch (e) {
      throw Exception();
    }
    return weatherModel;
  }
}

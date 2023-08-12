import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/error_message_model.dart';
import '../models/weather_model.dart';

abstract class BaseWeatherRemoteDateSource {
  Future<WeatherModel> getWeatherByCityName(Map<String, dynamic> query);

  Future<List<WeatherModel>> getWeatherForFiveDays(Map<String, dynamic> query);
}

class WeatherRemoteDateSource extends BaseWeatherRemoteDateSource {
  @override
  Future<WeatherModel> getWeatherByCityName(Map<String, dynamic> query) async {
    final response = await Dio().get(ApiConstants.weatherUrl, queryParameters: {
      'appid': ApiConstants.apiKey,
    });
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<WeatherModel>> getWeatherForFiveDays(Map<String, dynamic> query) async {
    final response = await Dio().get(ApiConstants.weatherUrl, queryParameters: {
      'appid': ApiConstants.apiKey,
    });
    if (response.statusCode == 200) {
      return List.from(
        (response.data['list'] as List).map(
          (e) => WeatherModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}

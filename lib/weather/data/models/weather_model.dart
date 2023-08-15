import 'package:weather_app/core/services/local/cash_helper.dart';

import '../../domain/entity/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required super.cityName,
    required super.main,
    required super.description,
    required super.humidity,
    required super.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json["name"] ?? CashHelper.getData(key: 'city') ?? '',
      main: json["weather"][0]["main"],
      description: json["weather"][0]["description"],
      humidity: json["main"]["humidity"],
      icon: json["weather"][0]["icon"],
    );
  }
}

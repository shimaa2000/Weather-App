import 'package:weather_app/core/services/local/cash_helper.dart';

import '../../domain/entity/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required super.cityName,
    required super.main,
    required super.description,
    required super.pressure,
    required super.humidity,
    required super.temp,
    required super.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json["name"] ?? CashHelper.getData(key: 'city') ?? '',
      main: json["weather"][0]["main"],
      description: json["weather"][0]["description"],
      pressure: json["main"]["pressure"],
      temp: json["main"]["temp"],
      humidity: json["main"]["humidity"],
      icon: json["weather"][0]["icon"],
    );
  }
}

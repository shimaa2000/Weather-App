import '../../domain/entity/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required super.id,
    required super.cityName,
    required super.main,
    required super.description,
    required super.pressure,
    required super.humidity,
    required super.temp,
    required super.icon,
    required super.windSpeed,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      id: json["id"],
      cityName: json["name"],
      main: json["weather"][0]["main"],
      description: json["weather"][0]["description"],
      pressure: json["main"]["pressure"],
      temp: json["main"]["temp"],
      humidity: json["main"]["humidity"],
      icon: json["weather"][0]["icon"],
      windSpeed: json["wind"]["speed"],
    );
  }
}

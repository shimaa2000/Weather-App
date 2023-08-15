import 'package:flutter/material.dart';
import 'package:weather_app/weather/domain/entity/weather.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({Key? key, required this.weather}) : super(key: key);
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Text(
          weather.cityName,
          style: TextStyle(
            color: Colors.white,
            fontSize: width * .08,
          ),
        ),
        Text(
          '${(weather.humidity - 32) * 5 ~/ 9} \u2103',
          style: TextStyle(
            color: Colors.white,
            fontSize: width * .1,
          ),
        ),
        Text(
          weather.main,
          style: TextStyle(
            color: Colors.white,
            fontSize: width * .05,
          ),
        ),
        Text(
          weather.description,
          style: TextStyle(
            color: Colors.white,
            fontSize: width * .04,
          ),
        ),
      ],
    );
  }
}

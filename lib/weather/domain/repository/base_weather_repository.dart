import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';

import '../entity/weather.dart';

abstract class BaseWeatherRepository {
  Future<Either<Failure,Weather>> getWeatherByCityName(Map<String,dynamic>query);
  Future<Either<Failure,List<Weather>>> getWeatherForFiveDays(Map<String,dynamic> query);
}

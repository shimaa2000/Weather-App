
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entity/weather.dart';
import '../repository/base_weather_repository.dart';

class GetWeatherByCountryName {
  final BaseWeatherRepository repository;

  GetWeatherByCountryName(this.repository);

  Future<Either<Failure,Weather>> call(Map<String,dynamic> query) async {
    return await repository.getWeatherByCityName(query);
  }
}

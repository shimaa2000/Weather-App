import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entity/weather.dart';
import '../repository/base_weather_repository.dart';

class GetWeatherForFiveDays{
  final BaseWeatherRepository _baseWeatherRepository;

  GetWeatherForFiveDays(this._baseWeatherRepository);

  Future<Either<Failure,List<Weather>>> call(Map<String,dynamic> query) async {
    return await _baseWeatherRepository.getWeatherForFiveDays(query);
  }
}

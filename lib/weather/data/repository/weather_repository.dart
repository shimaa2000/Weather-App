import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:weather_app/weather/data/data_source/weather_remote_data_source.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../domain/entity/weather.dart';
import '../../domain/repository/base_weather_repository.dart';

class WeatherRepository extends BaseWeatherRepository{
  final BaseWeatherRemoteDateSource _baseWeatherRemoteDateSource;

  WeatherRepository(this._baseWeatherRemoteDateSource);
  @override
  Future<Either<Failure, Weather>> getWeatherByCityName(
      Map<String, dynamic> query) async {
    try {
      final result = await _baseWeatherRemoteDateSource.getWeatherByCityName(query);
      log(result.toString());

      return Right(result);
    } on ServerException catch (failure) {
      log(failure.errorMessageModel.statusMessage);
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Weather>>> getWeatherForFiveDays(
      Map<String, dynamic> query) async {
    try {
      final result = await _baseWeatherRemoteDateSource.getWeatherForFiveDays(query);
      log(result.toString());
      return Right(result);
    } on ServerException catch (failure) {
      log(failure.errorMessageModel.statusMessage);
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
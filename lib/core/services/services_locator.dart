import 'package:get_it/get_it.dart';
import '../../weather/data/data_source/weather_remote_data_source.dart';
import '../../weather/domain/repository/base_weather_repository.dart';
import '../../weather/domain/use_case/get_weather_by_city_name.dart';
import '../../weather/data/repository/weather_repository.dart';
import '../../weather/domain/use_case/get_weather_for_five_days.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    ///USE_CASES
    sl.registerLazySingleton(() => GetWeatherByCountryName(sl()));
    sl.registerLazySingleton(() => GetWeatherForFiveDays(sl()));

    ///Repository
    sl.registerLazySingleton<BaseWeatherRepository>(() => WeatherRepository(sl()));

    ///REMOTE_DATA_SOURCE
    sl.registerLazySingleton<BaseWeatherRemoteDateSource>(() => WeatherRemoteDateSource());
  }
}

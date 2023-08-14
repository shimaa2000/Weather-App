import 'package:equatable/equatable.dart';
import 'package:weather_app/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(const WeatherState());
}

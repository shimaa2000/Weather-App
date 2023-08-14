part of 'weather_cubit.dart';

class WeatherState extends Equatable {
  const WeatherState({
    this.networkState=NetworkState.connected,
    this.message='',
    this.getTodayWeatherState=RequestState.initial,
});
  final RequestState getTodayWeatherState;
  final NetworkState networkState;
  final String message;


  @override
  List<Object> get props => [];

}


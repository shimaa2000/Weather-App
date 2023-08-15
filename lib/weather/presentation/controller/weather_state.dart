part of 'weather_cubit.dart';

class WeatherState extends Equatable {
  const WeatherState({
    this.networkState = NetworkState.connected,
    this.message = '',
    this.getTodayWeatherState = RequestState.initial,
    this.weather,
    this.currentAddress,
    this.currentPosition,
  });

  final RequestState getTodayWeatherState;
  final NetworkState networkState;
  final String message;
  final Weather? weather;
  final String? currentAddress;
  final Position? currentPosition;

  @override
  List<Object> get props => [
        getTodayWeatherState,
        networkState,
        message,
      ];

  WeatherState copyWith({
    RequestState? getTodayWeatherState,
    NetworkState? networkState,
    String? message,
    Weather? weather,
    String? currentAddress,
    Position? currentPosition,
  }) =>
      WeatherState(
        message: message ?? this.message,
        getTodayWeatherState: getTodayWeatherState ?? this.getTodayWeatherState,
        networkState: networkState ?? this.networkState,
        weather: weather ?? this.weather,
        currentAddress: currentAddress ?? this.currentAddress,
        currentPosition: currentPosition ?? this.currentPosition,
      );
}

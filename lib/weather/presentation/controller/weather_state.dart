part of 'weather_cubit.dart';

class WeatherState extends Equatable {
  const WeatherState({
    this.networkState = NetworkState.connected,
    this.message = '',
    this.getTodayWeatherState = RequestState.initial,
    this.weather,
    this.fiveDaysWeather = const [],
    this.currentAddress,
    this.fiveDaysWeatherState = RequestState.initial,
    this.currentPosition,
    this.isEditing = true,
    this.addressState=AddressState.fetching,
  });

  final RequestState getTodayWeatherState;
  final RequestState fiveDaysWeatherState;
  final AddressState addressState;
  final NetworkState networkState;
  final String message;
  final Weather? weather;
  final List<Weather> fiveDaysWeather;
  final String? currentAddress;
  final Position? currentPosition;
  final bool isEditing;

  @override
  List<Object?> get props => [
        getTodayWeatherState,
        fiveDaysWeatherState,
        networkState,
        message,
        weather,
        fiveDaysWeather,
        currentAddress,
        currentPosition,
        isEditing,
    addressState,
      ];

  WeatherState copyWith({
    RequestState? getTodayWeatherState,
    RequestState? fiveDaysWeatherState,
    NetworkState? networkState,
    String? message,
    bool? isEditing,
    Weather? weather,
    String? currentAddress,
    Position? currentPosition,
    List<Weather>? fiveDaysWeather,
    AddressState? addressState,
  }) =>
      WeatherState(
        message: message ?? this.message,
        isEditing: isEditing ?? this.isEditing,
        getTodayWeatherState: getTodayWeatherState ?? this.getTodayWeatherState,
        networkState: networkState ?? this.networkState,
        weather: weather ?? this.weather,
        addressState: addressState?? this.addressState,
        currentAddress: currentAddress ?? this.currentAddress,
        currentPosition: currentPosition ?? this.currentPosition,
        fiveDaysWeather: fiveDaysWeather ?? this.fiveDaysWeather,
        fiveDaysWeatherState: fiveDaysWeatherState ?? this.fiveDaysWeatherState,
      );
}

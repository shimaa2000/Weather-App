import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/services/local/cash_helper.dart';
import '../../../core/utils/enums.dart';
import '../../domain/entity/weather.dart';
import '../../domain/use_case/get_weather_by_city_name.dart';
import '../../domain/use_case/get_weather_for_five_days.dart';

import '../../../core/network/api_constants.dart';
import '../../../core/services/network_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherByCountryName, this._weatherForFiveDays)
      : super(const WeatherState()) {
    NetworkService().addListener((status) {
      if (status.disconnected) {
        emit(state.copyWith(networkState: NetworkState.disconnected));
      }
      if (status.connected) {
        emit(state.copyWith(networkState: NetworkState.connected));
        if (searchController.text.isNotEmpty) {
          getTodayWeather(city: searchController.text);
        } else {
          getTodayWeather();
          getFiveDaysWeather();
        }
      }
    });
  }

  final GetWeatherByCountryName _weatherByCountryName;
  final GetWeatherForFiveDays _weatherForFiveDays;

  static WeatherCubit get(context) => BlocProvider.of(context);

  Future<Position?> _getCurrentPosition() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      emit(state.copyWith(currentPosition: position));
      log(position.toString());
      return position;
    });
    return position;
  }

  final searchController = TextEditingController();

  Future<String?> _getAddressFromLatLng() async {
    Position? position = await _getCurrentPosition();
    log('$position');

    final placeMarks =
        await placemarkFromCoordinates(position!.latitude, position.longitude)
            .then((List<Placemark> placeMarks) {
      Placemark place = placeMarks[0];
      emit(state.copyWith(currentAddress: place.country));
      log('${place.country}');
      CashHelper.saveData(key: 'city', value: placeMarks[0].locality);
      return place.locality;
    }).whenComplete(() => getTodayWeather());
    emit(state.copyWith(addressState: AddressState.done));
    return placeMarks;
  }

  void getTodayWeather({String? city}) async {
    String? address = CashHelper.getData(key: 'city') ?? 'Cairo';

    emit(state.copyWith(getTodayWeatherState: RequestState.loading));
    if (await NetworkService().isConnected) {
      final result = await _weatherByCountryName({
        'q': city ?? address ?? 'Cairo',
        'appid': ApiConstants.apiKey,
      });
      result.fold((l) {
        Fluttertoast.showToast(
            msg: l.message,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        log(l.message);
        emit(state.copyWith(
            getTodayWeatherState: RequestState.error, message: l.message));
      }, (r) {
        CashHelper.saveData(key: 'main', value: r.main);
        CashHelper.saveData(key: 'description', value: r.description);
        CashHelper.saveData(key: 'temp', value: r.humidity);
        emit(
          state.copyWith(
            weather: r,
            getTodayWeatherState: RequestState.loaded,
          ),
        );
      });
    } else {
      emit(state.copyWith(networkState: NetworkState.disconnected));
    }
  }

  void getFiveDaysWeather() async {
    String? address =
        CashHelper.getData(key: 'city') ?? await _getAddressFromLatLng();

    emit(state.copyWith(fiveDaysWeatherState: RequestState.loading));
    if (await NetworkService().isConnected) {
      final result = await _weatherForFiveDays({
        'q': address ?? 'Cairo',
        'appid': ApiConstants.apiKey,
      });
      result.fold((l) {
        log(l.message);
        emit(state.copyWith(
            fiveDaysWeatherState: RequestState.error, message: l.message));
      }, (r) {
        emit(
          state.copyWith(
            fiveDaysWeather: r,
            fiveDaysWeatherState: RequestState.loaded,
          ),
        );
      });
    } else {
      emit(state.copyWith(networkState: NetworkState.disconnected));
    }
  }
}

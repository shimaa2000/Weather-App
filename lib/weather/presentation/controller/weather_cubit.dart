import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/services/local/cash_helper.dart';
import 'package:weather_app/core/utils/enums.dart';
import 'package:weather_app/weather/domain/entity/weather.dart';
import 'package:weather_app/weather/domain/use_case/get_weather_by_city_name.dart';
import 'package:weather_app/weather/domain/use_case/get_weather_for_five_days.dart';

import '../../../core/network/api_constants.dart';
import '../../../core/services/network_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherByCountryName, this._weatherForFiveDays) : super(const WeatherState());
  final GetWeatherByCountryName _weatherByCountryName;
  final GetWeatherForFiveDays _weatherForFiveDays;

  static WeatherCubit get(context) => BlocProvider.of(context);

  Future<Position?> _getCurrentPosition() async {
   await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      emit(state.copyWith(currentPosition: position));
      log(position.toString());
      return position;
    });
    return position;
  }

  final searchController = TextEditingController();

  changeIcon() {
    emit(state.copyWith(isEditing: searchController.text.isNotEmpty));
  }

  Future<String?> _getAddressFromLatLng() async {
    Position? position = await _getCurrentPosition();
    log('$position');

    final placeMarks = await placemarkFromCoordinates(position!.latitude, position.longitude)
        .then((List<Placemark> placeMarks) {
      Placemark place = placeMarks[0];
      emit(state.copyWith(currentAddress: place.country));
      log('${place.country}');
      CashHelper.saveData(key: 'city', value: placeMarks[0].locality);

      return place.locality;
    });
    return placeMarks;
  }

  void getTodayWeather({String? city}) async {
    String? address = CashHelper.getData(key: 'city') ?? await _getAddressFromLatLng();
    if (address != null) {
      emit(state.copyWith(getTodayWeatherState: RequestState.loading));
      if (await NetworkService().isConnected) {
        final result = await _weatherByCountryName({
          'q': city ?? address,
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
          emit(state.copyWith(getTodayWeatherState: RequestState.error, message: l.message));
        }, (r) {
          log(r.pressure.toString());

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
  }

  void getFiveDaysWeather() async {
    String? address = CashHelper.getData(key: 'city') ?? await _getAddressFromLatLng();
    if (address != null) {
      emit(state.copyWith(fiveDaysWeatherState: RequestState.loading));
      if (await NetworkService().isConnected) {
        final result = await _weatherForFiveDays({
          'q': address,
          'appid': ApiConstants.apiKey,
        });
        result.fold((l) {
          log(l.message);
          emit(state.copyWith(fiveDaysWeatherState: RequestState.error, message: l.message));
        }, (r) {
          log(r[0].pressure.toString());

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
}

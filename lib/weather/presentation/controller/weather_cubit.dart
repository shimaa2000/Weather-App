import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/weather/domain/entity/weather.dart';
import 'package:weather_app/weather/domain/use_case/get_weather_by_city_name.dart';

import '../../../core/services/network_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherByCountryName) : super(const WeatherState());
  final GetWeatherByCountryName _weatherByCountryName;



  Future<Position?> _getCurrentPosition() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      emit(state.copyWith(currentPosition: position));
      return position;
    }).catchError((e) {
      log(e.toString());
    });
    return null;
  }
  Future<void> _getAddressFromLatLng() async {
    Position? position=await _getCurrentPosition();
    log('$position');

    await placemarkFromCoordinates(
        position!.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      emit(state.copyWith(currentAddress: place.country));
    }).catchError((e) {
      debugPrint(e);
    });
  }


  void getTodayWeather({ String? city}) async {
    _getAddressFromLatLng();
    emit(state.copyWith(getTodayWeatherState: RequestState.loading));
    if (await NetworkService().isConnected) {
      final result = await _weatherByCountryName({
        'q': city?? state.currentAddress,
      });
      result.fold((l) {
        emit(state.copyWith(
            getTodayWeatherState: RequestState.error, message: l.message));
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

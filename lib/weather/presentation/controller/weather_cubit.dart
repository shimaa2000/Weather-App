import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      emit(state.copyWith(currentPosition: position));
      log(position.toString());
      return position;
    }).catchError((e) {
      log(e.toString());
      return null;
    });
    return position;
  }
  Future<String?> _getAddressFromLatLng() async {
    Position? position=await _getCurrentPosition();
    log('$position');

    final placeMarks=await placemarkFromCoordinates(
        position!.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      emit(state.copyWith(currentAddress: place.country));
      log('${place.country}');
      return place.country;
    }).catchError((e) {
      debugPrint(e);
      return null;
    });
    return placeMarks;
  }


  void getTodayWeather({ String? city}) async {
    String? address=await _getAddressFromLatLng();
    log(address!);
    if(address!=null) {
      emit(state.copyWith(getTodayWeatherState: RequestState.loading));
      if (await NetworkService().isConnected) {
        final result = await _weatherByCountryName({
          'q': city ?? address,
        });
        result.fold((l) {
          log(l.message);
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
}

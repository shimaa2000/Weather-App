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

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
          msg: 'Location services are disabled. Please enable the services',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
            msg: 'Location permission is denied',
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    return true;
  }



  Future<Position?> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return null;
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

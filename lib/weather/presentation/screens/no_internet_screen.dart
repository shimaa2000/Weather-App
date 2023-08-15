import 'package:flutter/material.dart';
import 'package:weather_app/core/services/local/cash_helper.dart';

import '../../../core/constants/app_images.dart';
import '../../data/models/weather_model.dart';
import '../components/current_weather_widget.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      height: height,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            AppImages.backgroundImage,
          ),
        ),
      ),
      child: CashHelper.getData(key: 'temp') == null
          ? Center(
              child: Text(
                'No internet or saved data!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.sizeOf(context).width * .06,
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                CurrentWeatherWidget(
                    weather: WeatherModel(
                  icon: '',
                  cityName: CashHelper.getData(key: 'city'),
                  description: CashHelper.getData(key: 'description'),
                  humidity: CashHelper.getData(key: 'temp'),
                  main: CashHelper.getData(key: 'main'),
                )),
                const Spacer(),
                Text(
                  'No internet Connection!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.sizeOf(context).width * .05,
                  ),
                )
              ],
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weather_app/core/services/local/cash_helper.dart';

import '../../../core/network/api_constants.dart';
import '../../domain/entity/weather.dart';

class DayWeather extends StatelessWidget {
  const DayWeather({Key? key, required this.weather}) : super(key: key);
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height / 5.5,
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .01,
        ),
        child: Card(
            color: Colors.blueAccent.withOpacity(.45),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 20.0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * .05,
                vertical: height * .02,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weather.cityName == CashHelper.getData(key: 'city')
                            ? 'My Location'
                            : weather.cityName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width * .06,
                        ),
                      ),
                      Row(children: [
                        if (weather.cityName == CashHelper.getData(key: 'city'))
                          Text(
                            weather.cityName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * .045,
                            ),
                          ),
                        SizedBox(
                          height: width*.1,
                          width: width*.1,
                          child: Image.network(
                              ApiConstants.imageUrl(weather.icon)),
                        ),
                      ],),

                      const Spacer(),
                      Text(
                        weather.description,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * .035,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${(weather.humidity - 32) * 5 ~/ 9} \u2103',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * .08,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        weather.main,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * .04,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

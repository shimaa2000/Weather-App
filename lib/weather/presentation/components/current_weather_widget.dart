import 'package:flutter/material.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Text(
          'Shebin El-Kom',
          style: TextStyle(
            color: Colors.white,
            fontSize: width*.08,
          ),
        ),Text(
          '26 \u2103',
          style: TextStyle(
            color: Colors.white,
            fontSize: width*.1,
          ),
        ),
        Text(
          'Rain',
          style: TextStyle(
            color: Colors.white,
            fontSize: width*.05,
          ),
        ),
        Text(
          'moderate rain',
          style: TextStyle(
            color: Colors.white,
            fontSize: width*.04,
          ),
        ),
      ],
    );
  }
}

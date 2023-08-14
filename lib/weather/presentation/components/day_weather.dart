import 'package:flutter/material.dart';

class DayWeather extends StatelessWidget {
  const DayWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height;
    final width=MediaQuery.sizeOf(context).width;
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                        'My Location',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width * .06,
                        ),
                      ),
                      Text(
                        'Shebin El-kom',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * .045,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'moderate rain',
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
                        '26 \u2103',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * .08,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Rain',
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

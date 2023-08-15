import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/weather/presentation/components/day_weather.dart';
import 'package:weather_app/weather/presentation/controller/weather_cubit.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/services/services_locator.dart';
import '../components/fade_on_scrolling_widget.dart';

class CurrentWeatherScreen extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  CurrentWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Container(
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            AppImages.backgroundImage,
          ),
        )),
        child: BlocProvider(
          create: (context) => WeatherCubit(sl())..getTodayWeather(),
          lazy: false,
          child: SafeArea(
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate:
                      SliverHeaderDelegateComponent(expandedHeight: height / 5),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(childCount: 5,
                      (BuildContext context, int index) {
                    return const DayWeather();
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

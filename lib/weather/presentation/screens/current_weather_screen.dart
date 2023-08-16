import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../components/day_weather.dart';
import '../controller/weather_cubit.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/utils/enums.dart';
import '../components/fade_on_scrolling_widget.dart';

class CurrentWeatherScreen extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  CurrentWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            AppImages.backgroundImage,
          ),
        )),
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.addressState) {
              case AddressState.fetching:
                return state.getTodayWeatherState == RequestState.error
                    ? Text(
                        'No Available weather for current Location',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * .05,
                        ),
                      )
                    : const CupertinoActivityIndicator();
              case AddressState.done:
                return SafeArea(
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        floating: true,
                        delegate: SliverHeaderDelegateComponent(
                            expandedHeight: height / 5),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: state.fiveDaysWeather.isEmpty ? 1 : 5,
                            (BuildContext context, int index) {
                          return state.fiveDaysWeatherState ==
                                  RequestState.loading
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * .04,
                                    vertical: height * .01,
                                  ),
                                  child: Shimmer.fromColors(
                                    baseColor:
                                        Colors.blueAccent.withOpacity(.3),
                                    highlightColor: Colors.blueAccent.shade700,
                                    child: Container(
                                      height: height / 5.5,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                )
                              : DayWeather(
                                  weather: state.fiveDaysWeather[index],
                                );
                        }),
                      )
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

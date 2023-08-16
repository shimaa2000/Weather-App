import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/enums.dart';
import 'package:weather_app/weather/presentation/screens/search_screen.dart';

import '../../../core/constants/app_images.dart';
import '../controller/weather_cubit.dart';
import 'current_weather_widget.dart';

class SliverHeaderDelegateComponent extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  const SliverHeaderDelegateComponent({required this.expandedHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final deadline = (expandedHeight + minExtent);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    double percent = shrinkOffset > deadline ? 1 : shrinkOffset / deadline;
    return BlocBuilder<WeatherCubit, WeatherState>(
      buildWhen: (previous, current) => previous.getTodayWeatherState != current.getTodayWeatherState,
      builder: (context, state) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => SizedBox(
            height: expandedHeight + expandedHeight / 2,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                if (shrinkOffset > expandedHeight + minExtent) // show it on collapse
                  Container(
                      height: height / 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          AppImages.backgroundImage,
                        ),
                      )),
                      child: state.getTodayWeatherState == RequestState.loading
                          ? const CupertinoActivityIndicator()
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    state.weather!.cityName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * .05,
                                    ),
                                  ),
                                  Text(
                                    '${(state.weather!.humidity - 32) * 5 ~/ 9} \u2103 | ${state.weather!.main}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * .03,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                PositionedDirectional(
                  start: 0.0,
                  end: 0.0,
                  bottom: 0,
                  child: Opacity(
                    opacity: 1 - percent,
                    child: state.getTodayWeatherState == RequestState.loading ||
                            state.getTodayWeatherState == RequestState.initial
                        ? const CupertinoActivityIndicator()
                        : Container(
                            height: MediaQuery.sizeOf(context).height / 4,
                            color: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                              child: Center(
                                child: CurrentWeatherWidget(weather: state.weather!),
                              ),
                            ),
                          ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(weather: state.weather!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

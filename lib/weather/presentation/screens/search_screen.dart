import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/weather/domain/entity/weather.dart';

import '../../../core/constants/app_images.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import '../components/day_weather.dart';
import '../controller/weather_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key, required this.weather}) : super(key: key);
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
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
          child: SafeArea(
            child: BlocProvider(
              create: (context) => WeatherCubit(sl(), sl()),
              child: BlocBuilder<WeatherCubit, WeatherState>(
                buildWhen: (previous, current) =>
                    previous.getTodayWeatherState != current.getTodayWeatherState,
                builder: (context, state) {
                  final cubit= WeatherCubit.get(context);
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: width * .05,
                          vertical: height * .02,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              width * 0.05,
                            ),
                          ),
                        ),
                        child: TextFormField(
                          controller: cubit.searchController,
                          onTapOutside: (event) => FocusScope.of(context).unfocus(),
                          cursorColor: Colors.white,
                          onFieldSubmitted: (value) =>
                             cubit.getTodayWeather(city: value),
                          decoration: InputDecoration(
                            hintText: 'Search for a city',
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.getTodayWeather(city: cubit.searchController.text);
                                FocusScope.of(context).unfocus();
                              },
                              icon:const Icon(Icons.search),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: height * .023,
                              horizontal: width * 0.025,
                            ),
                            suffixIconColor: Colors.black45,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(.3),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  width * 0.05,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(.3),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  width * 0.05,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  width * 0.05,
                                ),
                              ),
                            ),
                            fillColor: Colors.white.withOpacity(.3),
                          ),
                        ),
                      ),
                      state.getTodayWeatherState == RequestState.loading
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * .04,
                                vertical: height * .01,
                              ),
                              child: Shimmer.fromColors(
                                baseColor: Colors.blueAccent.withOpacity(.3),
                                highlightColor: Colors.blueAccent.shade700,
                                child: Container(
                                  height: height / 5.5,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            )
                          : DayWeather(weather: state.weather ?? weather),
                    ],
                  );
                },
              ),
            ),
          )),
    );
  }
}

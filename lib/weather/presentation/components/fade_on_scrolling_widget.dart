import 'package:flutter/material.dart';
import 'package:weather_app/weather/presentation/screens/search_screen.dart';

import '../../../core/constants/app_images.dart';
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Shebin El-Kom',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * .05,
                        ),
                      ),
                      Text(
                        '26 \u2103 | Rain',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * .03,
                        ),
                      ),
                    ],
                  )),
            PositionedDirectional(
              start: 0.0,
              end: 0.0,
              // top: appBarSize > 0 ? appBarSize : 0,
              bottom: 0,
              child: Opacity(
                opacity: 1 - percent,
                child: Container(
                  height: MediaQuery.sizeOf(context).height / 4,
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                    child: const Center(
                      child: CurrentWeatherWidget(),
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
                    builder: (context) =>const SearchScreen(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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

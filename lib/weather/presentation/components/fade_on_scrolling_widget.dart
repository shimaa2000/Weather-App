import 'package:flutter/material.dart';

class SliverHeaderDelegateComponent extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  const SliverHeaderDelegateComponent({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final deadline = (expandedHeight + minExtent);
    double percent = shrinkOffset > deadline ? 1 : shrinkOffset / deadline;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => SizedBox(
        height: expandedHeight + expandedHeight / 2,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if(shrinkOffset > expandedHeight + minExtent) // show it on collapse
                 Container(
                height: 200,
                width: double.infinity,
                color: Colors.red,child: const Center(child: Text('Weather data'))),

            PositionedDirectional(
              start: 0.0,
              end: 0.0,
              // top: appBarSize > 0 ? appBarSize : 0,
              bottom: 0,
              child: Opacity(
                opacity: 1 - percent,
                child: SizedBox(
                  height: 300,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                    child: const Card(
                      elevation: 20.0,
                      child: Center(
                        child: Text("Weather data"),
                      ),
                    ),
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
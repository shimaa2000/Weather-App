import 'package:flutter/material.dart';
import '../components/fade_on_scrolling_widget.dart';

class CurrentWeatherScreen extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  CurrentWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
      
        body: SafeArea(
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              const SliverPersistentHeader(
                pinned: true,
                delegate: SliverHeaderDelegateComponent(expandedHeight: 200),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(childCount: 5, (BuildContext context, int index) {
                  return  Container(
                    height: 200,
                    color: Colors.transparent,
                    child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30 ),
                        child:  Card(
                          elevation: 20.0,
                          child: Center(
                            child: Text("Weather $index"),
                          ),
                        ),),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

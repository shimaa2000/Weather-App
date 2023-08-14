import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:weather_app/weather/presentation/screens/current_weather_screen.dart';

import '../../../core/services/network_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext? rootContext;

  final networkService = NetworkService();

  @override
  void initState() {
    networkService.addListener((status) {
      if (status.disconnected) {
        rootContext?.loaderOverlay.show();
      }
      if (status.connected) {
        rootContext?.loaderOverlay.hide();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          rootContext = context;
          networkService.isConnected.then((value) {
            if (!value) rootContext?.loaderOverlay.show();
          });
          return LoaderOverlay(
            overlayWidget:const Scaffold(
              body: Center(child: Text('No internet')),
            ),
            useDefaultLoading: false,
            child: child!,
          );
        },
        home: CurrentWeatherScreen(),
      ),
    );
  }
}

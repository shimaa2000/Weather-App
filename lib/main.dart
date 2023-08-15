import 'package:flutter/material.dart';
import 'package:weather_app/weather/presentation/screens/home_screen.dart';

import 'core/services/services_locator.dart';

void main() {
  ServicesLocator().init();
  runApp(const  HomeScreen(),);
}

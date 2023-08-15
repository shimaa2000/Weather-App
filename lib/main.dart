import 'package:flutter/material.dart';
import 'package:weather_app/weather/presentation/screens/home_screen.dart';

import 'core/services/local/cash_helper.dart';
import 'core/services/services_locator.dart';

void main() async{
  ServicesLocator().init();
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  runApp(const  HomeScreen(),);
}

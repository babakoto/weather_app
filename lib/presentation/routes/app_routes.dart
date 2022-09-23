import 'package:flutter/cupertino.dart';
import 'package:weather_app/presentation/pages/home/home_page.dart';
import 'package:weather_app/presentation/pages/login/login_page.dart';
import 'package:weather_app/presentation/pages/weather/weather_page.dart';

abstract class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    HomePage.route: (context) => const HomePage(),
    LoginPage.route: (context) => const LoginPage(),
    WeatherPage.route: (context) => const WeatherPage(),
  };
}

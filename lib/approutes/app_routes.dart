import 'package:flutter/cupertino.dart';
import 'package:shakti/presentation/ui/screens/home_screen.dart';
import 'package:shakti/presentation/ui/screens/splash_screen.dart';

class AppRoutes{
  static String initialRoute = '/splash_screen';
  static String homeScreen = '/home_screen';
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      AppRoutes.initialRoute: (context) => const SplashScreen(),
      AppRoutes.homeScreen: (context) =>  const HomeScreen(),
    };
  }
}
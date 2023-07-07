import 'package:flutter/material.dart';
import 'package:shakti/core/constants/assets.dart';
import 'package:shakti/presentation/ui/screens/Info_list_screen.dart';
import 'package:shakti/presentation/ui/screens/resource_screen.dart';

class NavigatorScreen extends StatelessWidget {
  const NavigatorScreen({Key? key}) : super(key: key);
  static final homeKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: homeKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
              builder = (BuildContext _) => const ResourceScreen();
              break;
            case InfoListScreen.route:
              builder = (BuildContext _) {
                return InfoListScreen();
              };
              break;
            default:
              builder = (BuildContext _) => const ResourceScreen();
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        });
  }
}

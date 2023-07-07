import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shakti/core/constants/assets.dart';
import 'package:shakti/presentation/ui/screens/Info_list_screen.dart';
import 'package:shakti/presentation/ui/screens/navigator_screen.dart';
import 'package:shakti/presentation/ui/screens/audio_list_screen.dart';
import 'package:shakti/presentation/ui/screens/resource_screen.dart';
import 'package:shakti/presentation/ui/screens/stations_list_screen.dart';
import '../../../core/utils/NavbarNotifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final NavbarNotifier _navbarNotifier = NavbarNotifier();
  int backpressCount = 0;
  final _screens = <Widget>[
    const NavigatorScreen(),
    AudioListScreen(),
    StationsListScreen(),
    InfoListScreen(
      dataJsonPath: Assets.aboutJSon,
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool isExitingApp =
            await _navbarNotifier.onBackButtonPressed(_selectedIndex);
        if (isExitingApp) {
          if (backpressCount > 1) {
            return isExitingApp;
          } else {
            backpressCount++;
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Center(child: Text("press again to exit app")),
              ));
            }
            return false;
          }
        } else {
          return isExitingApp;
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: IndexedStack(
              index: _selectedIndex,
              children: _screens), //_widgetOptions(context),
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.resources,
                  width: 24,
                  height: 24,
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      _selectedIndex == 0 ? Colors.pink : Colors.white,
                      BlendMode.srcIn),
                ),
                label: 'Resources',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.home,
                  width: 24,
                  height: 24,
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      _selectedIndex == 1 ? Colors.pink : Colors.white,
                      BlendMode.srcIn),
                ),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.near_me),
                label: 'Near By',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.about,
                  width: 24,
                  height: 24,
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      _selectedIndex == 3 ? Colors.pink : Colors.white,
                      BlendMode.srcIn),
                ),
                label: 'About',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.pink,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.black87,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

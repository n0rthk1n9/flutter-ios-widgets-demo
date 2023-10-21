import 'package:flutter/cupertino.dart';
import 'package:flutter_ios_widgets_demo/update_greeting_widget_tab_view.dart';
import 'package:flutter_ios_widgets_demo/update_weather_widget_tab_view.dart';

class CupertinoWidgetsDemoHomePage extends StatelessWidget {
  const CupertinoWidgetsDemoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Greeting',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.sun_max_fill),
            label: 'Weather',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                child: UpdateGreetingWidgetTab(),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                child: UpdateWeatherWidgetTab(),
              );
            });
          default:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                child: UpdateGreetingWidgetTab(),
              );
            });
        }
      },
    );
  }
}

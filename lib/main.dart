import 'package:flutter/cupertino.dart';
import 'package:flutter_ios_widgets_demo/cupertino_widgets_demo_home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoWidgetsDemoHomePage(),
    );
  }
}

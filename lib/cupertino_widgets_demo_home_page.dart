import 'package:flutter/cupertino.dart';

class CupertinoWidgetsDemoHomePage extends StatelessWidget {
  const CupertinoWidgetsDemoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Widgets Demo'),
      ),
      child: Container(),
    );
  }
}

import 'package:flutter_ios_widgets_demo/weather_data.dart';
import 'package:flutter_ios_widgets_demo/styles.dart';
import 'package:home_widget/home_widget.dart';
import 'package:flutter/cupertino.dart';

const String appGroupId = 'group.flutterioswidgetsdemoflutterhamburgmeetup';
const String iOSWidgetName = 'WeatherWidget';

class UpdateWeatherWidgetTab extends StatefulWidget {
  const UpdateWeatherWidgetTab({super.key});
  @override
  State<UpdateWeatherWidgetTab> createState() => _UpdateWeatherWidgetTabState();
}

void updateWeather(Weather newWeather) {
  HomeWidget.saveWidgetData<String>('weather_sfsymbol', newWeather.symbol);
  HomeWidget.saveWidgetData<String>('weather_condition', newWeather.condition);
  HomeWidget.saveWidgetData<String>('weather_temperature', newWeather.temperature);

  HomeWidget.updateWidget(
    iOSName: iOSWidgetName,
  );
}

class _UpdateWeatherWidgetTabState extends State<UpdateWeatherWidgetTab> {
  final TextEditingController symbolController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();

  @override
  void initState() {
    super.initState();

    HomeWidget.setAppGroupId(appGroupId);

    temperatureController.text = '°C';

    final newWeather = Weather(symbol: 'sun.max', condition: 'Sunny', temperature: '25 °C');
    updateWeather(newWeather);
  }

  @override
  void dispose() {
    symbolController.dispose();
    conditionController.dispose();
    temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Update Weather Widget'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoTextField(
                controller: symbolController,
                placeholder: 'Symbol (sun.max, cloud.rain, cloud.fog)',
                style: Styles.inputText,
                cursorColor: Styles.inputCursorColor,
                autocorrect: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: CupertinoTextField(
                controller: conditionController,
                placeholder: 'Condition (Sunny, Rainy, Cloudy)',
                style: Styles.inputText,
                cursorColor: Styles.inputCursorColor,
                autocorrect: false,
                textCapitalization: TextCapitalization.words,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: CupertinoTextField(
                controller: temperatureController,
                placeholder: 'Temperature',
                style: Styles.inputText,
                cursorColor: Styles.inputCursorColor,
              ),
            ),
            CupertinoButton(
              onPressed: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }

                final newWeather = Weather(
                  symbol: symbolController.text,
                  condition: conditionController.text,
                  temperature: temperatureController.text,
                );
                updateWeather(newWeather);
              },
              child: const Text('Update Weather'),
            ),
          ],
        ),
      ),
    );
  }
}

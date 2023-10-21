import 'package:flutter_ios_widgets_demo/greeting_data.dart';
import 'package:flutter_ios_widgets_demo/styles.dart';
import 'package:home_widget/home_widget.dart';
import 'package:flutter/cupertino.dart';

const String appGroupId = 'group.flutterioswidgetsdemoflutterhamburgmeetup';
const String iOSWidgetName = 'GreetingWidget';

class UpdateGreetingWidgetTab extends StatefulWidget {
  const UpdateGreetingWidgetTab({super.key});
  @override
  State<UpdateGreetingWidgetTab> createState() => _UpdateGreetingWidgetTabState();
}

void updateGreeting(Greeting newGreeting) {
  HomeWidget.saveWidgetData<String>('greeting_name', newGreeting.name);
  HomeWidget.saveWidgetData<String>('greeting_greeting', newGreeting.greeting);

  HomeWidget.updateWidget(
    iOSName: iOSWidgetName,
  );
}

class _UpdateGreetingWidgetTabState extends State<UpdateGreetingWidgetTab> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController greetingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    HomeWidget.setAppGroupId(appGroupId);

    final newGreeting = Greeting(name: 'Flutter Hamburg ⚓️', greeting: 'Moin');
    updateGreeting(newGreeting);
  }

  @override
  void dispose() {
    nameController.dispose();
    greetingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Update Greeting Widget'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoTextField(
                controller: nameController,
                placeholder: 'Name',
                style: Styles.inputText,
                cursorColor: Styles.inputCursorColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: CupertinoTextField(
                controller: greetingController,
                placeholder: 'Greeting',
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

                final newGreeting = Greeting(
                  name: nameController.text,
                  greeting: greetingController.text,
                );
                updateGreeting(newGreeting);
              },
              child: const Text('Update Greeting'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

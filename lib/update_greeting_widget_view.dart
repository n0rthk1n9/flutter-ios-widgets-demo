import 'package:flutter_ios_widgets_demo/greeting_data.dart';
import 'package:home_widget/home_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String appGroupId = 'group.flutterioswidgetsdemoflutterhamburgmeetup';
const String iOSWidgetName = 'GreetingWidget';

class UpdateGreetingWidget extends StatefulWidget {
  const UpdateGreetingWidget({super.key});
  @override
  State<UpdateGreetingWidget> createState() => _UpdateGreetingWidgetState();
}

void updateGreeting(Greeting newGreeting) {
  HomeWidget.saveWidgetData<String>('greeting', newGreeting.name);
  HomeWidget.saveWidgetData<String>('headline_description', newGreeting.greeting);

  HomeWidget.updateWidget(
    iOSName: iOSWidgetName,
  );
}

class _UpdateGreetingWidgetState extends State<UpdateGreetingWidget> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Greeting'),
        centerTitle: false,
        titleTextStyle: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          CupertinoTextField(
            controller: nameController,
            placeholder: 'Name',
          ),
          CupertinoTextField(
            controller: greetingController,
            placeholder: 'Greeting',
          ),
          CupertinoButton(
            onPressed: () {
              final newGreeting = Greeting(
                name: nameController.text,
                greeting: greetingController.text,
              );
              updateGreeting(newGreeting);
            },
            child: const Text("Update Greeting"),
          ),
        ],
      ),
    );
  }
}

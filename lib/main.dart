import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _counter = 0;
  String appGroupId = "group.homeScreenApp";
  String androidWidgetName = "MyHomeWidget";
  String dataKey = "widgetDataKey";
  String _message = 'Hello World!';

  @override
  void initState() {
    super.initState();

    HomeWidget.setAppGroupId(appGroupId);
    HomeWidget.widgetClicked.listen((Uri? uri) {
      _counter++;
      setState(() {
        _message = 'Widget clicked $_counter times';
      });
      if (uri != null) {
        log('Widget clicked with URI: $uri');
      } else {
        log(" Widget clicked! uti null");
      }
    });
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
      _message = 'Counter: $_counter';
    });

    String data = 'Counter value is $_counter';
    // Here you would typically call the method to update the home screen widget
    await HomeWidget.saveWidgetData(dataKey, data);
    await HomeWidget.updateWidget(
      androidName: androidWidgetName,
      iOSName: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: Text(_message, style: TextStyle(fontSize: 30))),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _incrementCounter(),
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}

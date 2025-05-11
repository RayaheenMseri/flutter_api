import 'package:flutter/material.dart';
import 'package:flutter_api/CovidStatesPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Integration',
      home: CovidStatsPage(),
    );
  }
}

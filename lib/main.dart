import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:job/feature/home/screens/HomeScreen.dart';

void main() {
  initializeDateFormatting('fr');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

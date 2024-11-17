import 'package:flutter/material.dart';
import 'screens/quote_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Quote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuoteScreen(),
    );
  }
}

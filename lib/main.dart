import 'package:flutter/material.dart';
import 'package:phone/screens/home.dart';
import 'package:phone/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().lightTheme,
      home: Home(),
    );
  }
}

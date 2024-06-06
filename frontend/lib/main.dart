import 'package:bookdf/features/home/presentation/screens/app_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookdf/themes/text_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookDF',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: textTheme,
      ),
      home: const AppScreen(),
    );
  }
}

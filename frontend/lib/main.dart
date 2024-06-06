import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/features/home/presentation/screens/app_screen.dart';
import '/utils/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: const MaterialApp(
        title: 'BookDF',
        debugShowCheckedModeBanner: false,
        home: AppScreen(),
      ),
    );
  }
}

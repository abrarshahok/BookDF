import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/utils/providers.dart';
import 'routes/app_router.dart';
import '/dependency_injection/dependency_injection.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp.router(
        routerConfig: appRouter.config(
          navigatorObservers: () => [ChuckerFlutter.navigatorObserver],
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/utils/providers.dart';
import 'routes/app_router.dart';
import '/dependency_injection/dependency_injection.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
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

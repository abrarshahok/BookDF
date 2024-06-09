import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'dependency_injection.config.dart';

final locator = GetIt.instance;

@InjectableInit(initializerName: r'$initGetIt')
void configureDependencies() => locator.$initGetIt();

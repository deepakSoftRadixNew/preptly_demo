import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

/// Global ServiceLocator instance
final getIt = GetIt.instance;

/// Configures the dependency injection container
@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();

/// Module for third-party dependencies that can't be annotated directly
@module
abstract class AppModule {
  // Register third-party dependencies here
  // @singleton
  // SomeExternalService get externalService => SomeExternalService();
}

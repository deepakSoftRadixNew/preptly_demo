# Routing and Dependency Injection

This document explains how routing and dependency injection are implemented in this project using go_router and get_it with injectable.

## Routing with go_router

The app uses [go_router](https://pub.dev/packages/go_router) for navigation instead of GetX. The configuration is centralized in the `AppRouter` class.

### Key Components

- **AppRouter** (`lib/core/routes/app_router.dart`): Defines all app routes and provides the router configuration.
- **AppRoutes** (`lib/core/routes/app_routes.dart`): Contains route path constants.
- **NavigationHelper** (`lib/core/routes/navigation_helper.dart`): Utility methods for navigation.

### Usage

```dart
// Navigate to a new route
NavigationHelper.goTo(context, AppRoutes.contactUs);

// Replace current route
NavigationHelper.replaceTo(context, AppRoutes.contactUs);

// Push a route (with back navigation)
await NavigationHelper.pushTo(context, AppRoutes.contactUs);

// Pop current route
NavigationHelper.pop(context);
```

## Dependency Injection with get_it and injectable

The app uses [get_it](https://pub.dev/packages/get_it) with [injectable](https://pub.dev/packages/injectable) for dependency injection instead of GetX.

### Key Components

- **di.dart** (`lib/core/di/di.dart`): Sets up the dependency injection container.
- **di.config.dart**: Auto-generated file that registers dependencies.

### Usage

#### Registering a Dependency

```dart
// Singleton (single instance for entire app)
@singleton
class ApiService {
  // Implementation
}

// Injectable (new instance created when requested)
@injectable
class ContactUsCubit extends Cubit<ContactUsState> {
  final ApiService _apiService;
  
  ContactUsCubit(this._apiService) : super(const ContactUsState());
  
  // Implementation
}
```

#### Retrieving a Dependency

```dart
// In a Widget
final apiService = getIt<ApiService>();

// In the build method of a screen
@override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (_) => getIt<ContactUsCubit>(),
    child: const ContactUsView(),
  );
}
```

## Migrating from GetX

This implementation replaces:

1. `GetMaterialApp` with `MaterialApp.router`
2. `Get.toNamed()` with `NavigationHelper.goTo()`
3. `Get.lazyPut()` with `@injectable` and `getIt.get()`

## Running Code Generation

After adding or modifying injectable classes, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This will generate the required dependency injection code. 
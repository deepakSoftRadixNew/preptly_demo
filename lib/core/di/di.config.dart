// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:preptly/core/services/api_service.dart';
import 'package:preptly/features/contact_us/cubit/contact_us_cubit.dart';

import '../../features/splash/cubit/splash_cubit.dart' as _i782;
import '../routes/app_router.dart' as _i629;
import '../services/api_service.dart' as _i137;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i782.SplashCubit>(() => _i782.SplashCubit());
    gh.singleton<_i629.AppRouter>(() => _i629.AppRouter());
    gh.singleton<_i137.ApiService>(() => _i137.ApiService());
    gh.factory<ContactUsCubit>(() => ContactUsCubit(gh<ApiService>()));
    return this;
  }
}

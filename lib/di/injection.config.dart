// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:event_bus/event_bus.dart' as _i4;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nutrisee/core/data/datasource/api/api_service.dart' as _i9;
import 'package:nutrisee/core/utils/media_service.dart' as _i6;
import 'package:nutrisee/core/utils/permission_service.dart' as _i7;
import 'package:nutrisee/core/utils/refresh_token_interceptor.dart' as _i8;
import 'package:nutrisee/di/app_modules.dart' as _i11;
import 'package:nutrisee/di/network_modules.dart' as _i10;

const String _dev = 'dev';

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    final appModule = _$AppModule();
    gh.factory<_i3.Dio>(
      () => networkModule.client,
      registerFor: {_dev},
    );
    gh.singleton<_i4.EventBus>(() => appModule.eventBus);
    gh.singleton<_i5.FlutterSecureStorage>(() => appModule.storage);
    gh.factory<_i6.MediaService>(() => _i6.MediaServiceImpl());
    gh.factory<_i7.PermissionService>(() => _i7.PermissionServiceHandler());
    gh.factory<_i8.RefreshTokenInterceptor>(
        () => _i8.RefreshTokenInterceptor(gh<_i5.FlutterSecureStorage>()));
    gh.factory<_i9.ApiService>(() => _i9.ApiService(gh<_i3.Dio>()));
    return this;
  }
}

class _$NetworkModule extends _i10.NetworkModule {}

class _$AppModule extends _i11.AppModule {}

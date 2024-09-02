// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;

import '../features/auth/data/repositories/auth/auth_repository_impl.dart'
    as _i986;
import '../features/auth/data/repositories/auth/data_sources/remote_auth_data_source/auth_remote_data_source.dart'
    as _i633;
import '../features/auth/data/repositories/auth/data_sources/remote_auth_data_source/auth_remote_data_source_impl.dart'
    as _i413;
import '../features/auth/domain/repositories/auth_repository.dart' as _i869;
import '../features/auth/presentation/screens/sign_in/sign_in_cubit.dart'
    as _i890;
import 'modules/network_module.dart' as _i851;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    gh.singleton<_i973.InternetConnectionChecker>(
        () => networkModule.getInternetConnectionChecker());
    gh.singleton<_i361.Dio>(() => networkModule.getDio());
    gh.factory<_i633.AuthRemoteDataSource>(
        () => _i413.AuthRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.factory<_i869.AuthRepository>(() => _i986.AuthRepositoryImpl(
          gh<_i633.AuthRemoteDataSource>(),
          gh<_i973.InternetConnectionChecker>(),
        ));
    gh.factory<_i890.SignInCubit>(
        () => _i890.SignInCubit(gh<_i869.AuthRepository>()));
    return this;
  }
}

class _$NetworkModule extends _i851.NetworkModule {}

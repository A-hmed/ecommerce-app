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

import '../auth/data/repos/auth_repo_impl.dart' as _i861;
import '../auth/data/repos/online_datasource.dart' as _i544;
import '../auth/data/repos/online_datasource_impl.dart' as _i33;
import '../auth/domain/repo/auth_repo.dart' as _i254;
import '../auth/domain/usecases/login_usecase.dart' as _i556;
import '../auth/presentation/screens/sign_in/sign_in_viewmodel.dart' as _i1073;
import '../main_layout/data/repository/home_repository/data_sources/home_remote_data_source.dart'
    as _i864;
import '../main_layout/data/repository/home_repository/data_sources/home_remote_data_source_impl.dart'
    as _i711;
import '../main_layout/data/repository/home_repository/home_repository_impl.dart'
    as _i106;
import '../main_layout/domain/mappers/cateogry_mapper.dart' as _i419;
import '../main_layout/domain/mappers/product_mapper.dart' as _i300;
import '../main_layout/domain/repository/home_repository.dart' as _i639;
import '../main_layout/domain/usecases/categories_usecase.dart' as _i289;
import '../main_layout/domain/usecases/most_selling_products_usecase.dart'
    as _i231;
import '../main_layout/ui/home/presentation/home_cubit/home_cubit.dart'
    as _i1069;
import '../utils/dio_utils.dart' as _i427;
import '../utils/shared_pref_utils.dart' as _i299;
import 'network_module.dart' as _i567;

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
    gh.factory<_i427.DioUtils>(() => _i427.DioUtils());
    gh.factory<_i299.SharedPrefUtils>(() => _i299.SharedPrefUtils());
    gh.factory<_i419.CategoryMapper>(() => _i419.CategoryMapper());
    gh.factory<_i300.ProductMapper>(() => _i300.ProductMapper());
    gh.singleton<_i361.Dio>(() => networkModule.getDio());
    gh.singleton<_i973.InternetConnectionChecker>(
        () => networkModule.getChecker());
    gh.factory<_i544.OnlineDataSource>(() => _i33.OnlineDataSourceImpl(
          gh<_i361.Dio>(),
          gh<_i299.SharedPrefUtils>(),
        ));
    gh.factory<_i864.HomeRemoteDataSource>(
        () => _i711.HomeRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.factory<_i639.HomeRepository>(() => _i106.HomeRepositoryImpl(
          gh<_i864.HomeRemoteDataSource>(),
          gh<_i973.InternetConnectionChecker>(),
          gh<_i419.CategoryMapper>(),
          gh<_i300.ProductMapper>(),
        ));
    gh.factory<_i254.AuthRepo>(
        () => _i861.AuthRepoImpl(gh<_i544.OnlineDataSource>()));
    gh.factory<_i556.LoginUseCase>(
        () => _i556.LoginUseCase(gh<_i254.AuthRepo>()));
    gh.factory<_i1073.SignInViewModel>(
        () => _i1073.SignInViewModel(gh<_i556.LoginUseCase>()));
    gh.factory<_i289.GetCategoriesUseCase>(
        () => _i289.GetCategoriesUseCase(gh<_i639.HomeRepository>()));
    gh.factory<_i231.MostSellingProductsUseCase>(
        () => _i231.MostSellingProductsUseCase(gh<_i639.HomeRepository>()));
    gh.factory<_i1069.HomeCubit>(() => _i1069.HomeCubit(
          gh<_i289.GetCategoriesUseCase>(),
          gh<_i231.MostSellingProductsUseCase>(),
        ));
    return this;
  }
}

class _$NetworkModule extends _i567.NetworkModule {}

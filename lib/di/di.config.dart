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
import '../features/base/data/utils/shared_pref_utls.dart' as _i4;
import '../features/main_layout/data/repositories/home_repo/data_sources/home_remote_data_source.dart'
    as _i968;
import '../features/main_layout/data/repositories/home_repo/data_sources/home_remote_data_source_impl.dart'
    as _i686;
import '../features/main_layout/data/repositories/home_repo/home_repository_impl.dart'
    as _i76;
import '../features/main_layout/domain/mappers/category_mapper.dart' as _i415;
import '../features/main_layout/domain/mappers/product_mapper.dart' as _i648;
import '../features/main_layout/domain/repositories/home_repository.dart'
    as _i833;
import '../features/main_layout/domain/usecase/get_categories_usecase.dart'
    as _i705;
import '../features/main_layout/domain/usecase/get_product_usecase.dart'
    as _i914;
import '../features/main_layout/domain/usecase/get_sub_categories_by_category_usecase.dart'
    as _i475;
import '../features/main_layout/home/presentation/cubit/home_cubit.dart'
    as _i875;
import '../features/products_screen/domain/get_products_by_category.dart'
    as _i663;
import '../features/products_screen/presentation/screens/cubit/products_screen_cubit.dart'
    as _i983;
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
    gh.factory<_i4.SharedPrefUtils>(() => _i4.SharedPrefUtils());
    gh.factory<_i415.CategoryMapper>(() => _i415.CategoryMapper());
    gh.singleton<_i973.InternetConnectionChecker>(
        () => networkModule.getInternetConnectionChecker());
    gh.singleton<_i361.Dio>(() => networkModule.getDio());
    gh.factory<_i968.HomeRemoteDataSource>(
        () => _i686.HomeRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.factory<_i633.AuthRemoteDataSource>(() => _i413.AuthRemoteDataSourceImpl(
          gh<_i361.Dio>(),
          gh<_i4.SharedPrefUtils>(),
        ));
    gh.factory<_i648.ProductMapper>(
        () => _i648.ProductMapper(gh<_i415.CategoryMapper>()));
    gh.factory<_i833.HomeRepository>(() => _i76.HomeRepositoryImpl(
          gh<_i968.HomeRemoteDataSource>(),
          gh<_i973.InternetConnectionChecker>(),
          gh<_i415.CategoryMapper>(),
          gh<_i648.ProductMapper>(),
        ));
    gh.factory<_i869.AuthRepository>(() => _i986.AuthRepositoryImpl(
          gh<_i633.AuthRemoteDataSource>(),
          gh<_i973.InternetConnectionChecker>(),
        ));
    gh.factory<_i705.GetCategoriesUseCase>(
        () => _i705.GetCategoriesUseCase(gh<_i833.HomeRepository>()));
    gh.factory<_i914.GetProductsUseCase>(
        () => _i914.GetProductsUseCase(gh<_i833.HomeRepository>()));
    gh.factory<_i475.GetSubCategoriesByCategoryUseCase>(() =>
        _i475.GetSubCategoriesByCategoryUseCase(gh<_i833.HomeRepository>()));
    gh.factory<_i663.GetProductsByCategoryUseCase>(
        () => _i663.GetProductsByCategoryUseCase(gh<_i833.HomeRepository>()));
    gh.factory<_i983.ProductsScreenCubit>(() =>
        _i983.ProductsScreenCubit(gh<_i663.GetProductsByCategoryUseCase>()));
    gh.factory<_i875.HomeCubit>(() => _i875.HomeCubit(
          gh<_i705.GetCategoriesUseCase>(),
          gh<_i914.GetProductsUseCase>(),
          gh<_i475.GetSubCategoriesByCategoryUseCase>(),
        ));
    gh.factory<_i890.SignInCubit>(
        () => _i890.SignInCubit(gh<_i869.AuthRepository>()));
    return this;
  }
}

class _$NetworkModule extends _i851.NetworkModule {}

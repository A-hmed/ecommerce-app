import 'package:ecommerce_app/features/base/base_api_state.dart';
import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/usecase/get_categories_usecase.dart';
import 'package:ecommerce_app/features/main_layout/domain/usecase/get_product_usecase.dart';
import 'package:ecommerce_app/features/main_layout/domain/usecase/get_sub_categories_by_category_usecase.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/cubit/home_cubit.dart';
import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([
  GetCategoriesUseCase,
  GetProductsUseCase,
  GetSubCategoriesByCategoryUseCase
])
main() {
  group("Home cubit", () {
    ///Arrange
    late GetCategoriesUseCase getCategoriesUseCase = MockGetCategoriesUseCase();
    late GetProductsUseCase getProductsUseCase = MockGetProductsUseCase();
    late GetSubCategoriesByCategoryUseCase getSubCategoriesByCategoryUseCase =
        MockGetSubCategoriesByCategoryUseCase();

    late HomeCubit cubit = HomeCubit(getCategoriesUseCase, getProductsUseCase,
        getSubCategoriesByCategoryUseCase);

    test("loadCategories emits loading once it is called", () {
      Either<Failure, List<Category>> expectedResult = Left(Failure(""));

      provideDummy(expectedResult);
      when(getCategoriesUseCase.execute())
          .thenAnswer((_) async => expectedResult);

      cubit.loadCategories();

      expect(cubit.state.categoriesApiState, isA<BaseLoadingState>());
    });

    test("getCategoriesUseCase return an empty list ", () async {
      Either<Failure, List<Category>> expectedResult = Right([]);

      provideDummy(expectedResult);
      when(getCategoriesUseCase.execute())
          .thenAnswer((_) async => expectedResult);

      await cubit.loadCategories();

      expect(cubit.state.categoriesApiState, isA<BaseSuccessState>());
      expect(cubit.state.selectedCategory, isNull);
    });

    test("getCategoriesUseCase returns list of categories ", () async {
      Category emptyCategory = Category(id: "id", name: "name", image: "image");
      Either<Failure, List<Category>> expectedResult = Right([emptyCategory]);

      provideDummy(expectedResult);
      when(getCategoriesUseCase.execute())
          .thenAnswer((_) async => expectedResult);

      await cubit.loadCategories();

      expect(cubit.state.categoriesApiState, isA<BaseSuccessState>());
      expect(cubit.state.selectedCategory, equals(emptyCategory));
    });

    test("getCategoriesUseCase returns Failure ", () async {
      Either<Failure, List<Category>> expectedResult =
          Left(Failure("Test error message"));

      provideDummy(expectedResult);
      when(getCategoriesUseCase.execute())
          .thenAnswer((_) async => expectedResult);

      await cubit.loadCategories();

      expect(cubit.state.categoriesApiState, isA<BaseErrorState>());
      expect(cubit.state.categoriesApiState.toString(), "Test error message");
    });

    test(
        "setSelectedCategory should change selected category"
        " calls _getSubCategoriesByCategoryUseCase", () {
      Category testCategory = Category(id: "id", name: "name", image: "image");
      when(getSubCategoriesByCategoryUseCase.execute(testCategory.id))
          .thenAnswer((_) async => Left(Failure("")));

      cubit.setSelectedCategory(testCategory);
      expect(cubit.state.selectedCategory, testCategory);
      verify(getSubCategoriesByCategoryUseCase.execute(testCategory.id));
    });
  });
}

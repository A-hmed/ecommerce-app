import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/utils/base_api_state.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/ui/home/presentation/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/features/main_layout/ui/home/presentation/home_cubit/home_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_card_item.dart';
import 'sub_category_item.dart';

class SubCategoriesList extends StatelessWidget {
  const SubCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: CustomScrollView(
        slivers: <Widget>[
          // category title
          SliverToBoxAdapter(
            child: Text(
              'Laptops & Electronics',
              style: getBoldStyle(
                  color: ColorManager.primary, fontSize: FontSize.s14),
            ),
          ),
          // the category card
          SliverToBoxAdapter(
            child: CategoryCardItem("Laptops & Electronics",
                ImageAssets.categoryCardImage, goToCategoryProductsListScreen),
          ),
          // the grid view of the subcategories
          BlocBuilder<HomeCubit, HomeCubitState>(
            buildWhen: (oldState, newState) {
              return oldState.subCategoriesApi != newState.subCategoriesApi;
            },
            builder: (context, state) {
              if (state.subCategoriesApi is BaseSuccessState) {
                BaseSuccessState<List<Category>> successState =
                    state.subCategoriesApi as BaseSuccessState<List<Category>>;
                return buildSubCategoriesList(successState.data);
              } else if (state.subCategoriesApi is BaseErrorState) {
                String errorMessage = (state.subCategoriesApi as BaseErrorState)
                    .failure
                    .errorMessage;
                return SliverToBoxAdapter(child: ErrorWidget(errorMessage));
              } else {
                return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          )
        ],
      ),
    );
  }

  SliverGrid buildSubCategoriesList(List<Category> subCategories) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: subCategories.length,
          (context, index) => SubCategoryItem(
              subCategories[index], goToCategoryProductsListScreen),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.75,
          mainAxisSpacing: AppSize.s8,
          crossAxisSpacing: AppSize.s8,
        ));
  }

  goToCategoryProductsListScreen() {
    // todo implement this function
  }
}

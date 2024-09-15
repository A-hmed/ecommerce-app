import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/base/base_api_state.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/widgets/category_card_item.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/cubit/home_cubit.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/cubit/home_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sub_category_item.dart';

class SubCategoriesList extends StatefulWidget {
  const SubCategoriesList({super.key});

  @override
  State<SubCategoriesList> createState() => _SubCategoriesListState();
}

class _SubCategoriesListState extends State<SubCategoriesList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeCubitState>(
      builder: (context, state) {
        return Expanded(
          flex: 2,
          child: CustomScrollView(
            slivers: <Widget>[
              // category title
              SliverToBoxAdapter(
                child: Text(
                  state.selectedCategory!.name,
                  style: getBoldStyle(
                      color: ColorManager.primary, fontSize: FontSize.s14),
                ),
              ),
              // the category card
              SliverToBoxAdapter(
                child: CategoryCardItem(
                    state.selectedCategory!.name,
                    ImageAssets.categoryCardImage,
                    goToCategoryProductsListScreen),
              ),
              // the grid view of the subcategories
              buildSubCategoriesList(state.subCategoriesApiState)
            ],
          ),
        );
      },
    );
  }

  Widget buildSubCategoriesList(BaseApiState subCategoriesApi) {
    if (subCategoriesApi is BaseSuccessState<List<Category>>) {
      List<Category> subCategories = subCategoriesApi.data;
      return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: subCategories.length,
            (context, index) => SubCategoryItem(
                subCategories[index].name,
                ImageAssets.subcategoryCardImage,
                goToCategoryProductsListScreen),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.75,
            mainAxisSpacing: AppSize.s8,
            crossAxisSpacing: AppSize.s8,
          ));
    } else if (subCategoriesApi is BaseErrorState) {
      return SliverToBoxAdapter(child: ErrorWidget(subCategoriesApi));
    } else {
      return SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()));
    }
  }

  goToCategoryProductsListScreen() {
    Navigator.pushNamed(context, Routes.productsScreenRoute,
        arguments:
            BlocProvider.of<HomeCubit>(context).state.selectedCategory!.id);
  }
}

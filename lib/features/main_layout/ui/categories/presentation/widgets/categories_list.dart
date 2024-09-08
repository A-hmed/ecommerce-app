import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/utils/base_api_state.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/ui/home/presentation/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/features/main_layout/ui/home/presentation/home_cubit/home_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_item.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  // Index of the currently selected category
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeCubitState>(
      buildWhen: (oldState, newState) {
        return oldState.categoriesApi != newState.categoriesApi;
      },
      builder: (context, state) {
        if (state.categoriesApi is BaseSuccessState) {
          BaseSuccessState<List<Category>> successState =
              state.categoriesApi as BaseSuccessState<List<Category>>;
          return buildCategoriesList(successState.data);
        } else if (state.categoriesApi is BaseErrorState) {
          BaseErrorState errorState = state.categoriesApi as BaseErrorState;
          return ErrorWidget(errorState.failure.errorMessage);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Expanded buildCategoriesList(List<Category> categories) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        color: ColorManager.containerGray,
        border: Border(
            // set the border for only 3 sides
            top: BorderSide(
                width: AppSize.s2,
                color: ColorManager.primary.withOpacity(0.3)),
            left: BorderSide(
                width: AppSize.s2,
                color: ColorManager.primary.withOpacity(0.3)),
            bottom: BorderSide(
                width: AppSize.s2,
                color: ColorManager.primary.withOpacity(0.3))),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSize.s12),
          bottomLeft: Radius.circular(AppSize.s12),
        ),
      ),

      // the categories items list
      child: ClipRRect(
        // clip the corners of the container that hold the list view
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSize.s12),
          bottomLeft: Radius.circular(AppSize.s12),
        ),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) => CategoryItem(
              index, categories[index], selectedIndex == index, onItemClick),
        ),
      ),
    ));
  }

  // callback function to change the selected index
  onItemClick(int index, Category category) {
    HomeCubit cubit = BlocProvider.of(context);
    cubit.loadSubCategories(category.id!);
    setState(() {
      selectedIndex = index;
    });
  }
}

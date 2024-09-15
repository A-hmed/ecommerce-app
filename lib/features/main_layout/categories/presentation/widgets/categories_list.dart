import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/base/base_api_state.dart';
import 'package:ecommerce_app/features/main_layout/categories/presentation/widgets/category_item.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/cubit/home_cubit.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/cubit/home_cubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: buildCategoriesList(),
    ));
  }

  Widget buildCategoriesList() {
    return BlocBuilder<HomeCubit, HomeCubitState>(
      builder: (context, state) {
        if (state.categoriesApiState is BaseSuccessState) {
          List<Category> categories =
              (state.categoriesApiState as BaseSuccessState<List<Category>>)
                  .data;
          return ClipRRect(
            // clip the corners of the container that hold the list view
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSize.s12),
              bottomLeft: Radius.circular(AppSize.s12),
            ),
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) => CategoryItem(index,
                  categories[index], selectedIndex == index, onItemClick),
            ),
          );
        } else if (state.categoriesApiState is BaseErrorState) {
          return ErrorWidget(state.categoriesApiState);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  // callback function to change the selected index
  onItemClick(Category category, int index) {
    BlocProvider.of<HomeCubit>(context).setSelectedCategory(category);
    setState(() {
      selectedIndex = index;
    });
  }
}

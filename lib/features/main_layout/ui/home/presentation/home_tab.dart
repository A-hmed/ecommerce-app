import 'dart:async';

import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/utils/base_api_state.dart';
import 'package:ecommerce_app/core/utils/dialog_utils.dart';
import 'package:ecommerce_app/core/widget/product_card.dart';
import 'package:ecommerce_app/features/cart/screens/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/main_layout/ui/home/presentation/home_cubit/home_cubit.dart';
import 'package:ecommerce_app/features/main_layout/ui/home/presentation/home_cubit/home_cubit_state.dart';
import 'package:ecommerce_app/features/main_layout/ui/home/presentation/widgets/custom_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/custom_ads_widget.dart';
import 'widgets/custom_section_bar.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late HomeCubit cubit = BlocProvider.of(context);
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> adsImages = [
    ImageAssets.carouselSlider1,
    ImageAssets.carouselSlider2,
    ImageAssets.carouselSlider3,
  ];

  @override
  void initState() {
    super.initState();
    _startImageSwitching();
  }

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % adsImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, BaseApiState>(
      listener: (context, state) {
        if (!context.mounted) return;
        if (state is BaseLoadingState) {
          showLoading(context);
        } else {
          hideLoading(context);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildAds(),
            Column(
              children: [
                CustomSectionBar(sectionNname: 'Categories', function: () {}),
                buildCategoriesGridView(),
                SizedBox(height: 12.h),
                //CustomSectionBar(sectionNname: 'Brands', function: () {}),
                // SizedBox(
                //   height: 270.h,
                //   child: GridView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (context, index) {
                //       return const CustomBrandWidget();
                //     },
                //     itemCount: 20,
                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //     ),
                //   ),
                // ),
                CustomSectionBar(
                  sectionNname: 'Most Selling Products',
                  function: () {},
                ),
                buildProductsListView(),
                SizedBox(height: 12.h),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildProductsListView() {
    return BlocBuilder<HomeCubit, HomeCubitState>(
      builder: (context, state) {
        if (state.productsApi is BaseSuccessState) {
          List<Product> product =
              (state.productsApi as BaseSuccessState<List<Product>>).data;
          return SizedBox(
            child: SizedBox(
              height: 360.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: product[index],
                  );
                },
                itemCount: product.length,
              ),
            ),
          );
        } else if (state.productsApi is BaseErrorState) {
          return ErrorWidget(
              (state.productsApi as BaseErrorState).failure.errorMessage);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildCategoriesGridView() {
    return BlocBuilder<HomeCubit, HomeCubitState>(
      builder: (context, state) {
        if (state.categoriesApi is BaseSuccessState) {
          List<Category> categories =
              (state.categoriesApi as BaseSuccessState<List<Category>>).data;
          return SizedBox(
            height: 270.h,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CustomCategoryWidget(
                  category: categories[index],
                );
              },
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
          );
        } else if (state.categoriesApi is BaseErrorState) {
          return ErrorWidget(
              (state.categoriesApi as BaseErrorState).failure.errorMessage);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  CustomAdsWidget buildAds() {
    return CustomAdsWidget(
      adsImages: adsImages,
      currentIndex: _currentIndex,
      timer: _timer,
    );
  }
}

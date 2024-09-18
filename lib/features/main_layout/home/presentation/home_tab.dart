import 'dart:async';

import 'package:ecommerce_app/core/widget/dialog_utils.dart';
import 'package:ecommerce_app/features/base/base_api_state.dart';
import 'package:ecommerce_app/features/cart/screens/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/cubit/home_cubit.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/cubit/home_cubit_state.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/widgets/custom_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/widget/product_card.dart';
import 'widgets/custom_ads_widget.dart';
import 'widgets/custom_section_bar.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> adsImages = [
    ImageAssets.carouselSlider1,
    ImageAssets.carouselSlider2,
    ImageAssets.carouselSlider3,
  ];
  late HomeCubit cubit = BlocProvider.of(context);
  late CartCubit cartCubit = BlocProvider.of(context);

  @override
  void initState() {
    super.initState();
    _startImageSwitching();
    cartCubit.subscription = cartCubit.stream.listen((state) {
      print("45- Listener: ${state}");
      if (state is BaseLoadingState) {
        showLoading(context);
      } else {
        hideLoading(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAdsWidget(
            adsImages: adsImages,
            currentIndex: _currentIndex,
            timer: _timer,
          ),
          Column(
            children: [
              CustomSectionBar(sectionNname: 'Categories', function: () {}),
              buildCategoriesSection(),
              CustomSectionBar(
                sectionNname: 'Most Selling Products',
                function: () {},
              ),
              buildProductsList(),
              SizedBox(height: 12.h),
            ],
          )
        ],
      ),
    );
  }

  Widget buildProductsList() {
    return BlocBuilder<HomeCubit, HomeCubitState>(
      bloc: cubit,
      builder: (context, state) {
        if (state.productApiState is BaseSuccessState<List<Product>>) {
          List<Product> products =
              (state.productApiState as BaseSuccessState<List<Product>>).data;
          return SizedBox(
            child: SizedBox(
              height: 360.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: products[index],
                  );
                },
                itemCount: products.length,
              ),
            ),
          );
        } else if (state.productApiState is BaseErrorState) {
          return ErrorWidget(
              (state.productApiState as BaseErrorState).failure.errorMessage);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildCategoriesSection() {
    return BlocBuilder<HomeCubit, HomeCubitState>(
      bloc: cubit,
      builder: (context, state) {
        if (state.categoriesApiState is BaseSuccessState) {
          BaseSuccessState<List<Category>> successState =
              state.categoriesApiState as BaseSuccessState<List<Category>>;
          return SizedBox(
            height: 280.h,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CustomCategoryWidget(
                  category: successState.data[index],
                );
              },
              itemCount: successState.data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
          );
        } else if (state.categoriesApiState is BaseErrorState) {
          BaseErrorState errorState =
              state.categoriesApiState as BaseErrorState;
          return ErrorWidget(errorState.failure.errorMessage);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
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
    print("158- Dispose");
    super.dispose();
  }
}

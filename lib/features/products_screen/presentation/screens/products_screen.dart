import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/core/widget/product_card.dart';
import 'package:ecommerce_app/di/di.dart';
import 'package:ecommerce_app/features/base/base_api_state.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/products_screen/presentation/screens/cubit/products_screen_cubit.dart';
import 'package:ecommerce_app/features/products_screen/presentation/screens/cubit/products_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/home_screen_app_bar.dart';

class ProductsScreen extends StatelessWidget {
  final String categoryId;

  const ProductsScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeScreenAppBar(
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<ProductsScreenCubit, ProductsScreenState>(
        bloc: getIt<ProductsScreenCubit>()..loadProducts(categoryId),
        builder: (context, state) {
          if (state.productsApiState is BaseSuccessState) {
            List<Product> products =
                (state.productsApiState as BaseSuccessState<List<Product>>)
                    .data;
            return buildProductsList(products);
          } else if (state is BaseErrorState) {
            return ErrorWidget(state);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Padding buildProductsList(List<Product> products) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 7 / 9,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.productDetails,
                          arguments: products[index]);
                    },
                    child: ProductCard(product: products[index]));
              },
              scrollDirection: Axis.vertical,
            ),
          )
        ],
      ),
    );
  }
}

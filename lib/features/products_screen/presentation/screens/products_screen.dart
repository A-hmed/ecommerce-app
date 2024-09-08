import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/utils/base_api_state.dart';
import 'package:ecommerce_app/features/di/di.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/products_screen/presentation/screens/cubit/products_cubit.dart';
import 'package:ecommerce_app/features/products_screen/presentation/screens/cubit/products_cubit_state.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/custom_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/home_screen_app_bar.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late String categoryId;
  ProductsCubit cubit = getIt();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print("2");
      cubit.loadProducts(categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    categoryId = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    print("1");
    return Scaffold(
      appBar: const HomeScreenAppBar(
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<ProductsCubit, ProductsCubitState>(
        bloc: cubit,
        builder: (context, state) {
          if (state.productsApi is BaseSuccessState) {
            BaseSuccessState<List<Product>> successState =
            state.productsApi as BaseSuccessState<List<Product>>;
            return buildProudctsList(successState.data);
          } else if (state.productsApi is BaseErrorState) {
            String errorMessage = (state.productsApi as BaseErrorState).failure
                .errorMessage;
            return ErrorWidget(errorMessage);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Padding buildProudctsList(List<Product> products) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 7 / 9,
        ),
        itemBuilder: (context, index) {
          return CustomProductWidget(product: products[index]);
        },
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

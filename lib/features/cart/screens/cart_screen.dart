import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/utils/base_api_state.dart';
import 'package:ecommerce_app/features/cart/domain/model/cart.dart';
import 'package:ecommerce_app/features/cart/screens/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/widgets/cart_item_widget.dart';
import 'package:ecommerce_app/features/cart/widgets/total_price_and_checkout_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartCubit cubit = BlocProvider.of(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p14),
        child: BlocBuilder<CartCubit, BaseApiState>(
          builder: (context, state) {
            if (state is BaseSuccessState<Cart>) {
              Cart cart = state.data;
              return Column(
                children: [
                  Expanded(
                    // the list of cart items ===============
                    child: ListView.builder(
                      itemBuilder: (context, index) => CartItemWidget(
                        imagePath: cart.products[index].image,
                        title: cart.products[index].title,
                        price: cart.products[index].price,
                        quantity: cart.products[index].numberOfItemsInCart,
                        onDeleteTap: () {
                          cubit.removeToCart(cart.products[index].id);
                        },
                        onDecrementTap: (count) {
                          cubit.updateItemQuantity(
                              cart.products[index].id, count);
                        },
                        onIncrementTap: (count) {
                          cubit.updateItemQuantity(
                              cart.products[index].id, count);
                        },
                        size: -1,
                        color: Colors.black,
                        colorName: 'Black',
                      ),
                      itemCount: cart.products.length,
                    ),
                  ),
                  // the total price and checkout button========
                  TotalPriceAndCheckoutButton(
                    totalPrice: cart.totalPrice,
                    checkoutButtonOnTap: () {},
                  ),
                  SizedBox(height: 10.h),
                ],
              );
            } else if (state is BaseErrorState) {
              return ErrorWidget((state).failure.errorMessage);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'Cart',
        style: getMediumStyle(fontSize: 20, color: ColorManager.textColor),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: ImageIcon(
            AssetImage(
              IconsAssets.icSearch,
            ),
            color: ColorManager.primary,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: ImageIcon(
            AssetImage(IconsAssets.icCart),
            color: ColorManager.primary,
          ),
        ),
      ],
    );
  }
}

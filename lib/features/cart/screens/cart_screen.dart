import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/base/base_api_state.dart';
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
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocBuilder<CartCubit, BaseApiState>(
        builder: (context, state) {
          CartCubit cubit = BlocProvider.of(context);
          if (state is BaseErrorState) {
            return ErrorWidget(state);
          }
          Cart? cart = cubit.latestCart;
          if (cart == null) return Container();
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: Column(
              children: [
                Expanded(
                  // the list of cart items ===============
                  child: ListView.builder(
                    itemBuilder: (context, index) => CartItemWidget(
                      imagePath: ImageAssets.categoryCardImage,
                      title: cart.products[index].title,
                      price: cart.products[index].totalCartPrice,
                      quantity: cart.products[index].totalItemsInCart.toInt(),
                      onDeleteTap: () {
                        cubit.removeProductFromCart(cart.products[index].id);
                      },
                      onDecrementTap: (quantity) {
                        print("quantity = ${quantity}");
                        cubit.updateProductCartQuantity(
                            cart.products[index].id, quantity - 1);
                      },
                      onIncrementTap: (quantity) {
                        print("quantity = ${quantity}");
                        cubit.updateProductCartQuantity(
                            cart.products[index].id, quantity + 1);
                      },
                      size: 0,
                      color: Colors.black,
                      colorName: 'Black',
                    ),
                    itemCount: cart.products.length,
                  ),
                ),
                // the total price and checkout button========
                TotalPriceAndCheckoutButton(
                  totalPrice: cart.totalCartPrice,
                  checkoutButtonOnTap: () {},
                ),
                SizedBox(height: 10.h),
              ],
            ),
          );
        },
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/resources/assets_manager.dart';
import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/utils/base_api_state.dart';
import 'package:ecommerce_app/features/cart/screens/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/main_layout/domain/model/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late CartCubit cartCubit = BlocProvider.of(context);

  String truncateTitle(String title) {
    List<String> words = title.split(' ');
    if (words.length <= 4) {
      return title;
    } else {
      return "${words.sublist(0, 4).join(' ')}..";
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 200.w,
      height: 280.h,
      child: Container(
        width: 280,
        margin: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: ColorManager.primary.withOpacity(0.8),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  buildProductImage(height),
                  buildWishListIcon(height, width),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      truncateTitle(widget.product.title),
                      maxLines: 1,
                      style: getMediumStyle(
                        color: ColorManager.primary,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      truncateTitle(widget.product.description),
                      maxLines: 2,
                      style: getRegularStyle(
                        color: ColorManager.primary,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    buildProductPriceRow(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildReviewRow(),
                        buildAddToCartButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddToCartButton() {
    return BlocBuilder<CartCubit, BaseApiState>(builder: (context, state) {
      bool isInCart = cartCubit.isProductInCart(widget.product.id);
      return InkWell(
        onTap: () {
          if (isInCart) {
            cartCubit.removeToCart(widget.product.id);
          } else {
            cartCubit.addToCart(widget.product.id);
          }
        },
        child: Icon(
          isInCart ? Icons.remove_circle : Icons.add_circle_rounded,
          color: ColorManager.primary,
          size: 36,
        ),
      );
    });
  }

  Row buildReviewRow() {
    return Row(
      children: [
        Text(
          "Reviews",
          style: getRegularStyle(
            color: ColorManager.primary,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          "${widget.product.rating}",
          style: getRegularStyle(
            color: ColorManager.primary,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Row buildProductPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "EGP ${widget.product.price}",
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: getRegularStyle(
            color: ColorManager.primary,
            fontSize: 14.sp,
          ),
        ),
        Text(
          "${widget.product.priceBeforeDiscount} EGP",
          style: getTextWithLine(),
        ),
      ],
    );
  }

  Positioned buildWishListIcon(double height, double width) {
    return Positioned(
      top: height * 0.01,
      right: width * 0.02,
      child: Container(
        height: height * 0.036,
        width: width * 0.08,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {},
          child: Image.asset(
            IconsAssets.icWithList,
            color: ColorManager.primary,
          ),
        ),
      ),
    );
  }

  SizedBox buildProductImage(double height) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: CachedNetworkImage(
            imageUrl: widget.product.image,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

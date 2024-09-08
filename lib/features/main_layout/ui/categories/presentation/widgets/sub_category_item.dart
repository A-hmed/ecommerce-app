import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/core/routes_manager/routes.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:flutter/material.dart';

class SubCategoryItem extends StatelessWidget {
  final Category category;
  final Function navigation;

  const SubCategoryItem(this.category, this.navigation, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("category.id = ${category.id}");
        Navigator.pushNamed(context, Routes.productsScreenRoute,
            arguments: category.id);
      },
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  border: Border.all(color: ColorManager.primary, width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s10),
                child: Image.network(
                  category.imageUrl ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            category.name ?? "",
            maxLines: 1,
            textAlign: TextAlign.center,
            style: getRegularStyle(color: ColorManager.primary),
          )
        ],
      ),
    );
  }
}

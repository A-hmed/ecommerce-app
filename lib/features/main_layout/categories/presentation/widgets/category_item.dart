import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/styles_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final int index;
  final bool isSelected;
  final Function onItemClick;

  const CategoryItem(
      this.index, this.category, this.isSelected, this.onItemClick,
      {super.key});

  @override
  Widget build(BuildContext context) {
    // Handle item click by calling onItemClick callback
    return InkWell(
      onTap: () => onItemClick(category, index),
      child: Container(
        // Set background color based on selection
        color: isSelected?ColorManager.white:Colors.transparent,
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Row(
          children: [
            //Show/hide the indicator based on selection
            Visibility(
              visible: isSelected,
              child: Container(
                width: AppSize.s8,
                height: AppSize.s60,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(AppSize.s100),
                ),
              ),
            ),
            // wrap the text with expanded to avoid overflow error
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p16, horizontal: AppPadding.p8),
              child: Text(
                category.name,
                textAlign: TextAlign.start,
                style: getMediumStyle(
                    color: ColorManager.primary, fontSize: FontSize.s14),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

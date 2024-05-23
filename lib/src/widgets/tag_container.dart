import 'package:flutter/material.dart';
import 'package:watchncook/src/helper/constants.dart';
import 'package:watchncook/src/widgets/custom_text.dart';

class CustomTagWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final String selectedIndex;
  final String currentIndex;

  const CustomTagWidget({
    Key? key,
    required this.onTap,
    required this.text,
    required this.selectedIndex,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentIndex == selectedIndex;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.mainColor : AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.mainColor),
          ),
          margin: const EdgeInsets.only(left: 5, right: 5),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: customText(
            context,
            text,
            color: isSelected ? AppColors.white : AppColors.black,
            size: 18,
          )),
    );
  }
}

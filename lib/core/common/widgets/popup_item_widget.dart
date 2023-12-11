import 'package:flutter/material.dart';
import 'package:tdd_bloc/core/constants/app_color.dart';

class PopupItemWidget extends StatelessWidget {
  const PopupItemWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.kColorBlack,
          ),
        ),
        icon,
      ],
    );
  }
}

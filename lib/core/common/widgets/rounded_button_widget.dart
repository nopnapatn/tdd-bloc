import 'package:flutter/material.dart';
import 'package:tdd_bloc/core/constants/app_color.dart';

class RoundedButtonWidget extends StatelessWidget {
  const RoundedButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.buttonColor,
    this.labelColor,
  });

  final String label;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? AppColors.kColorBlack,
        foregroundColor: labelColor ?? AppColors.kColorWhite,
        minimumSize: const Size(double.maxFinite, 50),
      ),
      child: Text(label),
    );
  }
}

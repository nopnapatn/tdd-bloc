import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tdd_bloc/core/constants/app_assets.dart';
import 'package:tdd_bloc/core/constants/app_colors.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: AppColors.kColorWhite,
        ),
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //   image: AssetImage(AppAssets.kImageExample),
        //   fit: BoxFit.cover,
        // )),
        child: SafeArea(
            child: Center(
          child: Lottie.asset(AppAssets.kLottieUnderConstruction),
        )),
      ),
    );
  }
}

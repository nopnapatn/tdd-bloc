import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tdd_bloc/core/common/widgets/gradient_background_widget.dart';
import 'package:tdd_bloc/core/constants/app_asset.dart';
import 'package:tdd_bloc/core/constants/app_color.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.kColorWhite,
        ),
        body: GradientBackgroundWidget(
            image: AppAssets.kImageBackground,
            child: Center(
              child: Lottie.asset(AppAssets.kLottieUnderConstruction),
            )));
  }
}

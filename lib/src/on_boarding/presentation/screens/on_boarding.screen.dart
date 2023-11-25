import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tdd_bloc/core/common/screens/splash_screen.dart';
import 'package:tdd_bloc/core/common/widgets/gradient_background_widget.dart';
import 'package:tdd_bloc/core/constants/app_assets.dart';
import 'package:tdd_bloc/core/constants/app_colors.dart';
import 'package:tdd_bloc/src/on_boarding/domain/entities/page_content.dart';
import 'package:tdd_bloc/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:tdd_bloc/src/on_boarding/presentation/widgets/on_boarding_body_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const route = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kColorWhite,
      body: GradientBackgroundWidget(
        image: AppAssets.kImageBackground,
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {
            if (state is OnBoardingStatus && !state.isFirstTimer) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state is UserCached) {}
          },
          builder: (context, state) {
            if (state is CheckingIfUserIsFirstTimer ||
                state is CachingFirstTimer) {
              return const SplashScreen();
            }
            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: const [
                    OnBoardingBodyWidget(pageContent: PageContent.first()),
                    OnBoardingBodyWidget(pageContent: PageContent.second()),
                    OnBoardingBodyWidget(pageContent: PageContent.thrid()),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, 0.04),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 40,
                      activeDotColor: AppColors.kColorWhite,
                      dotColor: AppColors.kColorWhite,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

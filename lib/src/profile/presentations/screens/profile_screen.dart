import 'package:flutter/material.dart';
import 'package:tdd_bloc/core/common/widgets/gradient_background_widget.dart';
import 'package:tdd_bloc/core/constants/app_asset.dart';
import 'package:tdd_bloc/core/constants/app_color.dart';
import 'package:tdd_bloc/src/profile/presentations/refactors/profile_body.dart';
import 'package:tdd_bloc/src/profile/presentations/refactors/profile_header.dart';
import 'package:tdd_bloc/src/profile/presentations/widgets/profile_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.kColorWhite,
      appBar: const ProfileAppBarWidget(),
      body: GradientBackgroundWidget(
        image: AppAssets.kImageBackground,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [
            ProfileHeader(),
            ProfileBody(),
          ],
        ),
      ),
    );
  }
}

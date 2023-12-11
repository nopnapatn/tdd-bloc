import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:tdd_bloc/core/common/providers/user_provider.dart';
import 'package:tdd_bloc/core/constants/app_color.dart';
import 'package:tdd_bloc/src/auth/data/models/user_model.dart';
import 'package:tdd_bloc/src/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:tdd_bloc/src/dashboard/presentation/utils/dashboard_util.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const route = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocalUserModel>(
        stream: DashboardUtil.userDataStream,
        builder: (_, snapshot) {
          if (snapshot.hasData && snapshot.data is LocalUserModel) {
            context.read<UserProvider>().user = snapshot.data;
          }
          return Consumer<DashboardController>(builder: (_, controller, __) {
            return Scaffold(
              body: IndexedStack(
                index: controller.currentIndex,
                children: controller.screens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.currentIndex,
                showSelectedLabels: false,
                backgroundColor: AppColors.kColorWhite,
                elevation: 8,
                onTap: controller.changeIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 0
                          ? IconlyBold.home
                          : IconlyLight.home,
                      color: controller.currentIndex == 0
                          ? AppColors.kColorBlack
                          : AppColors.kColorGray,
                    ),
                    label: 'Home',
                    backgroundColor: AppColors.kColorWhite,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 1
                          ? IconlyBold.document
                          : IconlyLight.document,
                      color: controller.currentIndex == 1
                          ? AppColors.kColorBlack
                          : AppColors.kColorGray,
                    ),
                    label: 'Materials',
                    backgroundColor: AppColors.kColorWhite,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 2
                          ? IconlyBold.chat
                          : IconlyLight.chat,
                      color: controller.currentIndex == 2
                          ? AppColors.kColorBlack
                          : AppColors.kColorGray,
                    ),
                    label: 'Chat',
                    backgroundColor: AppColors.kColorWhite,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 3
                          ? IconlyBold.profile
                          : IconlyLight.profile,
                      color: controller.currentIndex == 3
                          ? AppColors.kColorBlack
                          : AppColors.kColorGray,
                    ),
                    label: 'Profile',
                    backgroundColor: AppColors.kColorWhite,
                  ),
                ],
              ),
            );
          });
        });
  }
}

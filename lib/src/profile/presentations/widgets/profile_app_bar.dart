import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:tdd_bloc/core/common/widgets/popup_item_widget.dart';
import 'package:tdd_bloc/core/constants/app_color.dart';
import 'package:tdd_bloc/core/extensions/context_extensions.dart';
import 'package:tdd_bloc/core/services/injection_container.dart';
import 'package:tdd_bloc/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:tdd_bloc/src/profile/presentations/screens/edit_profile_screen.dart';

class ProfileAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfileAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kColorWhite,
        title: const Text(
          'Account',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        actions: [
          PopupMenuButton(
            surfaceTintColor: AppColors.kColorWhite,
            offset: const Offset(0, 50),
            icon: const Icon(Icons.more_horiz),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            itemBuilder: (_) => [
              PopupMenuItem<void>(
                onTap: () => context.push(BlocProvider(
                  create: (_) => sl<AuthBloc>(),
                  child: const EditProfileScreen(),
                )),
                child: const PopupItemWidget(
                  title: 'Edit Profile',
                  icon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.kColorBlack,
                  ),
                ),
              ),
              const PopupMenuItem<void>(
                child: PopupItemWidget(
                  title: 'Notification',
                  icon: Icon(
                    IconlyLight.notification,
                    color: AppColors.kColorBlack,
                  ),
                ),
              ),
              const PopupMenuItem<void>(
                child: PopupItemWidget(
                  title: 'Help',
                  icon: Icon(
                    Icons.help_outline_outlined,
                    color: AppColors.kColorBlack,
                  ),
                ),
              ),
              const PopupMenuItem<void>(
                height: 1,
                padding: EdgeInsets.zero,
                child: Divider(
                  height: 1,
                  color: AppColors.kColorGray,
                  indent: 8,
                  endIndent: 8,
                ),
              ),
              PopupMenuItem<void>(
                onTap: () async {
                  final navigator = Navigator.of(context);
                  await FirebaseAuth.instance.signOut();
                  unawaited(
                      navigator.pushNamedAndRemoveUntil('/', (route) => false));
                },
                child: const PopupItemWidget(
                  title: 'Logout',
                  icon: Icon(
                    Icons.logout_rounded,
                    color: AppColors.kColorBlack,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

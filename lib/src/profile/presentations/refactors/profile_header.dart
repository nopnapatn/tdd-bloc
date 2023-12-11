import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd_bloc/core/common/providers/user_provider.dart';
import 'package:tdd_bloc/core/constants/app_asset.dart';
import 'package:tdd_bloc/core/constants/app_color.dart';
import 'package:tdd_bloc/core/extensions/context_extensions.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (_, provider, __) {
      final user = provider.user;
      final image = user?.profileImage == null || user!.profileImage!.isEmpty
          ? null
          : user.profileImage;
      return Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: image != null
                ? NetworkImage(image)
                : const AssetImage(AppAssets.kImageAvatarFirst)
                    as ImageProvider,
            backgroundColor: AppColors.kColorGray,
          ),
          const SizedBox(height: 16),
          Text(
            user?.fullName ?? 'No User',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          if (user?.bio != null && user!.bio!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * .15),
              child: Text(
                user.bio!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.kColorGray,
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
        ],
      );
    });
  }
}

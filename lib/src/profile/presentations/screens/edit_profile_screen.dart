import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tdd_bloc/core/common/widgets/gradient_background_widget.dart';
import 'package:tdd_bloc/core/common/widgets/nested_back_button.dart';
import 'package:tdd_bloc/core/constants/app_asset.dart';
import 'package:tdd_bloc/core/constants/app_color.dart';
import 'package:tdd_bloc/core/enums/update_user.dart';
import 'package:tdd_bloc/core/extensions/context_extensions.dart';
import 'package:tdd_bloc/core/utils/core_utils.dart';
import 'package:tdd_bloc/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:tdd_bloc/src/profile/presentations/widgets/edit_profile_form_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();
  final oldPasswordController = TextEditingController();

  File? pickedImage;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  bool get nameChanged =>
      context.currentUser?.fullName.trim() != fullNameController.text.trim();
  bool get emailChanged => emailController.text.trim().isNotEmpty;
  bool get passwordChanged => passwordController.text.trim().isNotEmpty;
  bool get bioChanged =>
      context.currentUser?.bio?.trim() != bioController.text.trim();
  bool get imageChanged => pickedImage != null;
  bool get nothingChanged =>
      !nameChanged &&
      !emailChanged &&
      !passwordChanged &&
      !bioChanged &&
      !imageChanged;

  @override
  void initState() {
    fullNameController.text = context.currentUser!.fullName.trim();
    bioController.text = context.currentUser!.bio?.trim() ?? '';
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    oldPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserUpdated) {
          CoreUtils.showSnackBar(context, 'Profile updated Successfully');
          context.pop();
        } else if (state is AuthError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.kColorWhite,
          appBar: AppBar(
            leading: const NestedBackButton(),
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (nothingChanged) context.pop();
                    final bloc = context.read<AuthBloc>();
                    if (nameChanged) {
                      bloc.add(UpdateUserEvent(
                          action: UpdateUserAction.displayName,
                          userData: fullNameController.text.trim()));
                    }
                    if (bioChanged) {
                      bloc.add(UpdateUserEvent(
                          action: UpdateUserAction.bio,
                          userData: bioController.text.trim()));
                    }
                    if (emailChanged) {
                      bloc.add(UpdateUserEvent(
                          action: UpdateUserAction.email,
                          userData: emailController.text.trim()));
                    }
                    if (passwordChanged) {
                      if (oldPasswordController.text.isEmpty) {
                        CoreUtils.showSnackBar(
                            context, 'Please enter your old password');
                        return;
                      }
                      bloc.add(UpdateUserEvent(
                          action: UpdateUserAction.password,
                          userData: jsonEncode({
                            'oldPassword': oldPasswordController.text.trim(),
                            'newPassword': passwordController.text.trim(),
                          })));
                    }
                    if (imageChanged) {
                      bloc.add(UpdateUserEvent(
                          action: UpdateUserAction.profileImage,
                          userData: pickedImage));
                    }
                  },
                  child: state is AuthLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.kColorGray,
                          ),
                        )
                      : StatefulBuilder(builder: (_, refresh) {
                          fullNameController.addListener(() => refresh(() {}));
                          emailController.addListener(() => refresh(() {}));
                          passwordController.addListener(() => refresh(() {}));
                          bioController.addListener(() => refresh(() {}));
                          return Text(
                            'Done',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: nothingChanged
                                  ? AppColors.kColorGray
                                  : AppColors.kColorBlack,
                            ),
                          );
                        })),
            ],
          ),
          body: GradientBackgroundWidget(
            image: AppAssets.kImageBackground,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Builder(builder: (context) {
                  final user = context.currentUser!;
                  final userImage =
                      user.profileImage == null || user.profileImage!.isEmpty
                          ? null
                          : user.profileImage;
                  return Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: pickedImage != null
                            ? FileImage(pickedImage!)
                            : userImage != null
                                ? NetworkImage(userImage)
                                : const AssetImage(AppAssets.kImageAvatarFirst)
                                    as ImageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.kColorBlack.withOpacity(.5)),
                        ),
                        IconButton(
                          onPressed: pickImage,
                          icon: Icon(
                            (pickedImage != null || user.profileImage != null)
                                ? Icons.edit
                                : Icons.add_a_photo,
                            color: AppColors.kColorBlack,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'We recomend an image of at least 400x400',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.kColorGray,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                EditProfileFormWidget(
                  fullNameController: fullNameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  oldPasswordController: oldPasswordController,
                  bioController: bioController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

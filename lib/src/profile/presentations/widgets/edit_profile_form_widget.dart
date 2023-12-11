import 'package:flutter/material.dart';
import 'package:tdd_bloc/core/extensions/context_extensions.dart';
import 'package:tdd_bloc/core/extensions/string_extensions.dart';
import 'package:tdd_bloc/src/profile/presentations/widgets/edit_profile_form_field_widget.dart';

class EditProfileFormWidget extends StatelessWidget {
  const EditProfileFormWidget({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.oldPasswordController,
    required this.bioController,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController oldPasswordController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProfileFormFieldWidget(
          fieldTitle: 'Full Name',
          controller: fullNameController,
          hitText: context.currentUser!.fullName,
        ),
        EditProfileFormFieldWidget(
          fieldTitle: 'Bio',
          controller: bioController,
          hitText: context.currentUser!.bio,
        ),
        EditProfileFormFieldWidget(
          fieldTitle: 'Email',
          controller: emailController,
          hitText: context.currentUser!.email.obscureEmail,
        ),
        EditProfileFormFieldWidget(
          fieldTitle: 'Current Password',
          controller: oldPasswordController,
          hitText: '********',
        ),
        StatefulBuilder(builder: (_, setState) {
          oldPasswordController.addListener(
            () => setState(() {}),
          );
          return EditProfileFormFieldWidget(
            fieldTitle: 'New Password',
            controller: passwordController,
            hitText: '********',
            readOnly: oldPasswordController.text.isEmpty,
          );
        }),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tdd_bloc/core/common/widgets/i_field_wigget.dart';

class EditProfileFormFieldWidget extends StatelessWidget {
  const EditProfileFormFieldWidget({
    super.key,
    required this.fieldTitle,
    required this.controller,
    this.hitText,
    this.readOnly = false,
  });

  final String fieldTitle;
  final TextEditingController controller;
  final String? hitText;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            fieldTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 10),
        IFieldWidget(
          controller: controller,
          hintText: hitText,
          readOnly: readOnly,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

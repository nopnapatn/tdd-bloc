import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:tdd_bloc/core/common/widgets/i_field_wigget.dart';
import 'package:tdd_bloc/core/constants/app_color.dart';

class SignInFormWidget extends StatefulWidget {
  const SignInFormWidget({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<SignInFormWidget> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInFormWidget> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              IFieldWidget(
                controller: widget.emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          const SizedBox(height: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              IFieldWidget(
                controller: widget.passwordController,
                hintText: 'Password',
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    obscurePassword = !obscurePassword;
                  }),
                  icon: Icon(
                    obscurePassword ? IconlyLight.show : IconlyLight.hide,
                    color: AppColors.kColorGray,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

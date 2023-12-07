import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_bloc/core/common/providers/user_provider.dart';
import 'package:tdd_bloc/core/common/widgets/gradient_background_widget.dart';
import 'package:tdd_bloc/core/common/widgets/rounded_button_widget.dart';
import 'package:tdd_bloc/core/constants/app_asset.dart';
import 'package:tdd_bloc/core/constants/app_color.dart';
import 'package:tdd_bloc/core/utils/core_utils.dart';
import 'package:tdd_bloc/src/auth/data/models/user_model.dart';
import 'package:tdd_bloc/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:tdd_bloc/src/auth/presentation/screens/sign_in_screen.dart';
import 'package:tdd_bloc/src/auth/presentation/widgets/sign_up_form.dart';
import 'package:tdd_bloc/src/dashboard/presentation/screens/dashboard_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const route = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kColorWhite,
      body: BlocConsumer<AuthBloc, AuthState>(listener: (_, state) {
        if (state is AuthError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is SignedUp) {
          context.read<AuthBloc>().add(SignInEvent(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              ));
        } else if (state is SignedIn) {
          context.read<UserProvider>().initUser(state.user as LocalUserModel);
          Navigator.pushReplacementNamed(context, DashboardScreen.route);
        }
      }, builder: (context, state) {
        return GradientBackgroundWidget(
          image: AppAssets.kImageBackground,
          child: SafeArea(
              child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const Text(
                  'Easy to learn, discover more skills.',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Sign up to your account',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        SignInScreen.route,
                      );
                    },
                    child: const Text('Already have an account?'),
                  ),
                ),
                const SizedBox(height: 10),
                SignUpFormWidget(
                  formKey: formKey,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                  fullNameController: fullNameController,
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 30),
                if (state is AuthLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  RoundedButtonWidget(
                    label: 'Sign Up',
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      FirebaseAuth.instance.currentUser?.reload();
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(SignUpEvent(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              name: fullNameController.text.trim(),
                            ));
                      }
                    },
                  ),
              ],
            ),
          )),
        );
      }),
    );
  }
}

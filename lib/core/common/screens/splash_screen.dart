import 'package:flutter/material.dart';
import 'package:tdd_bloc/core/extensions/context_extension.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          context.theme.colorScheme.secondary,
        ),
      )),
    );
  }
}

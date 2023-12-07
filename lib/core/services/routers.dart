import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_bloc/core/common/screens/page_under_construction.dart';
import 'package:tdd_bloc/core/extensions/context_extension.dart';
import 'package:tdd_bloc/core/services/injection_container.dart';
import 'package:tdd_bloc/src/auth/data/models/user_model.dart';
import 'package:tdd_bloc/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:tdd_bloc/src/auth/presentation/screens/sign_in_screen.dart';
import 'package:tdd_bloc/src/auth/presentation/screens/sign_up_screen.dart';
import 'package:tdd_bloc/src/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:tdd_bloc/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:tdd_bloc/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:tdd_bloc/src/on_boarding/presentation/screens/on_boarding.screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = sl<SharedPreferences>();
      return _pageBuilder(
        (context) {
          if (prefs.getBool(kFirstTimerKey) ?? true) {
            BlocProvider(
              create: (_) => sl<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            );
          } else if (sl<FirebaseAuth>().currentUser != null) {
            final user = sl<FirebaseAuth>().currentUser!;
            final localUser = LocalUserModel(
              uid: user.uid,
              email: user.email ?? '',
              points: 0,
              fullName: user.displayName ?? '',
            );
            context.userProvider.initUser(localUser);
            return const DashboardScreen();
          }
          return BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const SignInScreen(),
          );
        },
        settings: settings,
      );

    case SignInScreen.route:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );

    case SignUpScreen.route:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );

    case DashboardScreen.route:
      return _pageBuilder(
        (_) => const DashboardScreen(),
        settings: settings,
      );

    // case '/forgot-password':
    //   return _pageBuilder(
    //     (_) => const fui.ForgotPasswordScreen(),
    //     settings: settings,
    //   );

    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, _, __) => page(context),
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}

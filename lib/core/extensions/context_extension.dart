import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_bloc/core/common/providers/tab_navigator.dart';
import 'package:tdd_bloc/core/common/providers/user_provider.dart';
import 'package:tdd_bloc/src/auth/domain/entities/user.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;
  double get height => size.height;
  double get width => size.width;

  UserProvider get userProvider => read<UserProvider>();
  LocalUser? get currentUser => userProvider.user;

  TabNavigator get tabNavigator => read<TabNavigator>();
  void pop() => tabNavigator.pop();
  void push(Widget screen) => tabNavigator.push(TabItem(child: screen));
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tdd_bloc/core/common/providers/tab_navigator.dart';

class PersistentScreen extends StatefulWidget {
  const PersistentScreen({
    super.key,
    this.body,
  });

  final Widget? body;

  @override
  State<PersistentScreen> createState() => _PersistentScreenState();
}

class _PersistentScreenState extends State<PersistentScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.body ?? context.watch<TabNavigator>().currentScreen.child;
  }

  @override
  bool get wantKeepAlive => true;
}

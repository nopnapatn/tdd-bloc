import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TabNavigator extends ChangeNotifier {
  TabNavigator(this._initialScreen) {
    _navigationStack.add(_initialScreen);
  }

  final TabItem _initialScreen;
  final List<TabItem> _navigationStack = [];

  TabItem get currentScreen => _navigationStack.last;

  void push(TabItem screen) {
    _navigationStack.add(screen);
    notifyListeners();
  }

  void pop() {
    if (_navigationStack.length > 1) _navigationStack.removeLast();
    notifyListeners();
  }

  void popToRoot() {
    _navigationStack
      ..clear()
      ..add(_initialScreen);
  }

  void popTo(TabItem screen) {
    _navigationStack.remove(screen);
    notifyListeners();
  }

  void popUntil(TabItem? screen) {
    if (screen == null) return popToRoot();
    if (_navigationStack.length > 1) {
      _navigationStack.removeRange(1, _navigationStack.indexOf(screen) + 1);
      notifyListeners();
    }
  }

  void pushAndRemoveUntil(TabItem screen) {
    _navigationStack
      ..clear()
      ..add(screen);
    notifyListeners();
  }
}

class TabNavigatorProvider extends InheritedNotifier<TabNavigator> {
  const TabNavigatorProvider({
    required this.navigator,
    required super.child,
    super.key,
  }) : super(notifier: navigator);

  final TabNavigator navigator;

  static TabNavigator? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TabNavigatorProvider>()
        ?.navigator;
  }
}

class TabItem extends Equatable {
  TabItem({required this.child}) : id = const Uuid().v1();

  final Widget child;
  final String id;

  @override
  List<dynamic> get props => [id];
}

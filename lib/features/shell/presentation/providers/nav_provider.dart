import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavTab {
  NavTab._();
  static const home = 0;
  static const cart = 1;
  static const profile = 2;
}

class NavIndexNotifier extends Notifier<int> {
  @override
  int build() => NavTab.home;

  void set(int index) => state = index;
}

final navIndexProvider =
    NotifierProvider<NavIndexNotifier, int>(NavIndexNotifier.new);

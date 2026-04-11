import 'package:flutter/foundation.dart';

class AppNavigationBridge extends ChangeNotifier {
  int _tabIndex = 0;

  int get tabIndex => _tabIndex;

  void setTab(int index) {
    if (index == _tabIndex || index < 0 || index > 3) {
      return;
    }
    _tabIndex = index;
    notifyListeners();
  }

  void goToApplications() => setTab(1);
}

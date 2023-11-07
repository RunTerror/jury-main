import 'package:flutter/material.dart';

class NavbarProvider with ChangeNotifier {
  int currentTab = 0;

  void setCurrentTab(int tab) {
    currentTab = tab;
    notifyListeners();
  }
}

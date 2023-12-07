// ignore_for_file: avoid_print

import 'models/user.dart';

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool _isSignupLoading = false;
  bool get isSignupLoading => _isSignupLoading;
  bool _isLoginLoading = false;
  bool get isLoaginLoading => _isLoginLoading;
  Info _user = Info(
    profile: '',
    name: '',
    location: '',
    lawyerId: '',
    mobileNumber: '',
    email: '',
    address: '',
    type: '',
    mtoken: '',
  );
  Info get user => _user;
  void setUser(Info user) {
    print(user.name);
    _user = user;
    print(user);
    notifyListeners();
  }

  toogleLoading() {
    _isSignupLoading = !_isSignupLoading;
    notifyListeners();
  }

  toogleLoginLoading() {
    _isLoginLoading = !_isLoginLoading;
    notifyListeners();
  }
}

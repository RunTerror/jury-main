// ignore_for_file: avoid_print

import 'models/user.dart';

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
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
}

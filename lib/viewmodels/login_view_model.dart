import 'package:flutter/material.dart';

import '../models/repositories/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  LoginViewModel({required this.userRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSuccessful = false;
  bool get isSuccessful => _isSuccessful;

  Future<bool> isSignIn() async {
    return await userRepository.isSignIn();
  }

  Future<void> signIn() async {
    _isLoading = true;
    notifyListeners();

    _isSuccessful = await userRepository.signIn();
    _isLoading = false;
    notifyListeners();
  }
}

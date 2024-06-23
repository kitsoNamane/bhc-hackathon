import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/auth_service.dart';
import '../firebase_options.dart';
import '../model/customer.dart';
import '../view/navigation_constants.dart';
import 'navigation_state.dart';

class ApplicationState extends ChangeNotifier {
  final _auth = FirebaseAuthService();
  final _navState = NavigationState();

  ApplicationState(){
    init();
  }
  bool _loggedIn = false;
  Customer? _user;
  bool get loggedIn => _loggedIn;
  GoRouter get router => _navState.router;
  Customer? get currentUser => _user;

  Future<void> init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  Future<void> signIn(String email, String password) async {
    _user = await _auth.signIn(email: email, password: password);
    _loggedIn = true;
    notifyListeners();
    _navState.changeNavState(isExistingCustomer: _user?.isExistingCustomer ?? false);
    router.go(
      NavigationConstants.homePath,
    );
  }

  Future<void> signUp(String email, String password) async {
    _user = await _auth.signUp(email: email, password: password);
    if (_user != null) {
      _user = await _auth.signIn(email: email, password: password);
      _loggedIn = true;
      notifyListeners();
      _navState.changeNavState(isExistingCustomer: _user?.isExistingCustomer ?? false);
      router.go(
        NavigationConstants.homePath,
      );
    } else {
      _navState.changeNavState(isExistingCustomer: _user?.isExistingCustomer ?? false);
      notifyListeners();
    }
  }

  void signOut() async {
    var isSignedOut = await _auth.signOut();
    if (isSignedOut) {
      _user = null;
      notifyListeners();
    }
  }
}
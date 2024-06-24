
import 'package:bhc_hackathon/data/sqlite_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/customer.dart';
import 'auth_service.dart';

class FirebaseAuthService extends AuthService {
  final _sqliteAuthService = SqliteAuthService();
  @override
  Future<Customer?> signIn({required String email, required String password}) async {
    try {
      var resp = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (resp.user == null) {
        return Future.value(null);
      }
      return await _sqliteAuthService.getCustomer(uuid: resp.user!.uid);
    } catch (e) {
      return Future.value(null);
    }
  }

  @override
  Future<Customer?> signUp({required String email, required String password}) async {
    try {
      var resp = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Future.value(
          Customer(
            uid: resp.user?.uid,
            phone: resp.user?.phoneNumber,
            email: resp.user?.email,
            isExistingCustomer: false,
          )
      );
    } catch (e) {
      return Future.value(null);
    }
  }

  @override
  Future<Customer?> userOnboarding({required Customer customer}) async {
    return await _sqliteAuthService.userOnboarding(customer: customer);
  }

  @override
  Future<bool> signOut({Customer? currentUser}) async {
    try {
      await FirebaseAuth.instance.signOut();
      return Future.value(
          true
      );
    } catch (e) {
      return Future.value(false);
    }
  }
}

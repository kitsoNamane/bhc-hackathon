
import 'package:firebase_auth/firebase_auth.dart';

import '../model/customer.dart';

abstract class AuthService {
  Future<Customer?> signUp({required String email, required String password});
  Future<Customer?> signIn({required String email, required String password});
  Future<bool> signOut({Customer? currentUser});
  Future<Customer?> userOnboarding({required Customer customer});
}

class FirebaseAuthService extends AuthService {
  @override
  Future<Customer?> signIn({required String email, required String password}) async {
    try {
      var resp = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Future.value(
          Customer(
            uuid: resp.user?.uid,
            phone: resp.user?.phoneNumber,
            email: resp.user?.email,
          )
      );
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
          uuid: resp.user?.uid,
          phone: resp.user?.phoneNumber,
          email: resp.user?.email,
        )
      );
    } catch (e) {
      return Future.value(null);
    }
  }

  @override
  Future<Customer?> userOnboarding({required Customer customer}) async {
    // TODO: implement userOnboarding
    throw UnimplementedError();
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
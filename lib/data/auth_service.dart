
import 'package:firebase_auth/firebase_auth.dart';

import '../model/customer.dart';

abstract class AuthService {
  Future<Customer?> signUp({required String email, required String password});
  Future<Customer?> signIn({required String email, required String password});
  Future<bool> signOut({Customer? currentUser});
  Future<Customer?> userOnboarding({required Customer customer});
}
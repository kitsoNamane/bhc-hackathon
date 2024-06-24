
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bhc_hackathon/data/auth_service.dart';
import 'package:bhc_hackathon/model/customer.dart';

class SqliteAuthService extends AuthService {
  final _apiBaseUrl = "https://bhc-api.fly.dev/api";

  @override
  Future<Customer?> signIn({required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  Future<Customer?> getCustomer({required String uuid}) async {
    final resp = await http
        .get(Uri.parse("$_apiBaseUrl/customer?uuid=$uuid"));

    if (resp.statusCode != 200) {
      return Future.value(null);
    }
    return Customer.fromJson(jsonDecode(resp.body) as Map<String, dynamic>);
  }

  @override
  Future<bool> signOut({Customer? currentUser}) {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Customer?> signUp({required String email, required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Customer?> userOnboarding({required Customer customer}) async {

    print(customer.toJson());
    try {
      final resp = await http.post(
        Uri.parse("$_apiBaseUrl/customer"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(customer.toJson()),
      );

      if (resp.statusCode != 200) {
        return Future.value(null);
      }
      return Customer.fromJson(jsonDecode(resp.body) as Map<String, dynamic>);
    } catch (e) {
      print("###########---------onboarding####################");
      print(e.toString());
      print("###########---------onboarding####################");
      return Future.value(null);
    }
  }
}
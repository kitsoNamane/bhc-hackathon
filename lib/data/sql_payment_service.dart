import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bhc_hackathon/model/payment.dart';

abstract class PaymentService {
  Future<Payment?> initiatePayment({required Payment payment});
  Future<List<Payment>?> getCustomerPayments({required String uuid});
  Future<Payment?> completePayment({required Payment payment});
}

class SqlitePaymentService extends PaymentService {
  final _apiBaseUrl = "https://bhc-api.fly.dev/api";

  @override
  Future<Payment?> completePayment({required Payment payment}) async {
    try {
      final resp = await http.put(
        Uri.parse("$_apiBaseUrl/payment"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payment.toJson()),
      );

      if (resp.statusCode != 200) {
        return Future.value(null);
      }
      return Payment.fromJson(jsonDecode(resp.body) as Map<String, dynamic>);
    } catch (e) {
      return Future.value(null);
    }
  }

  @override
  Future<List<Payment>?> getCustomerPayments({required String uuid}) async {
    try {
      final resp = await http
          .get(Uri.parse("$_apiBaseUrl/payment?uuid=$uuid"));

      if (resp.statusCode != 200) {
        return Future.value(null);
      }
      return Future.value(parseFaults(resp.body));
    } catch (e) {
      return Future.value(null);
    }
  }

  @override
  Future<Payment?> initiatePayment({required Payment payment}) async {
    try {
      final resp = await http.post(
        Uri.parse("$_apiBaseUrl/payment"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payment.toJson()),
      );

      if (resp.statusCode != 200) {
        return Future.value(null);
      }
      return Payment.fromJson(jsonDecode(resp.body) as Map<String, dynamic>);
    } catch (e) {
      return Future.value(null);
    }
  }

  List<Payment>? parseFaults(String responseBody) {
    final parsed = (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();
    return parsed.map<Payment>((json) => Payment.fromJson(json)).toList();
  }
}

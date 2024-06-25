import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:bhc_hackathon/model/fault.dart';

abstract class CRMService {
  Future<Fault?> createFault({required Fault fault});
  Future<List<Fault>?> getCustomerFaults({required String uuid});
}

class SqliteCRMService extends CRMService {
  final _apiBaseUrl = "https://bhc-api.fly.dev/api";

  @override
  Future<Fault?> createFault({required Fault fault}) async {
    // TODO: implement createFault

    try {
      final resp = await http.post(
        Uri.parse("$_apiBaseUrl/fault"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(fault.toJson()),
      );

      if (resp.statusCode != 200) {
        return Future.value(null);
      }
      return Fault.fromJson(jsonDecode(resp.body) as Map<String, dynamic>);
    } catch (e) {
      return Future.value(null);
    }
  }

  @override
  Future<List<Fault>?> getCustomerFaults({required String uuid}) async {
    try {
      final resp = await http
          .get(Uri.parse("$_apiBaseUrl/fault?uuid=$uuid"));

      if (resp.statusCode != 200) {
        return Future.value(null);
      }
      return Future.value(parseFaults(resp.body));
    } catch (e) {
      return Future.value(null);
    }
  }

  List<Fault>? parseFaults(String responseBody) {
    final parsed = (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();
    return parsed.map<Fault>((json) => Fault.fromJson(json)).toList();
  }
}
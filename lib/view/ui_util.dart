import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/fault.dart';

class UiUtil {
  static IconData ticketIcon(String type) {
    return switch (type.toLowerCase()) {
      "electrical" => Icons.flash_off_outlined,
      "carpentry" => Icons.table_bar_outlined,
      "plumbing" => Icons.plumbing_outlined,
      "masonry" => Icons.flood_outlined,
      "mechanical" => Icons.ac_unit_outlined,
      "external" => Icons.add_business_outlined,
      "success" => Icons.check_circle,
      "failed" => Icons.error,
      "cancelled" => Icons.cancel,
      String() => Icons.electric_bolt_outlined,
    };
  }

  static String ticketDueDate(String severity, String createdAt) {
    var date = DateTime.parse(createdAt);
    var parse = DateFormat("dd/MM/yyyy");
    return switch (severity) {
      "emergency" => parse.format(date.add(const Duration(days: 1))).toString(),
      "urgent" => parse.format(date.add(const Duration(days: 3))).toString(),
      "normal" => parse.format(date.add(const Duration(days: 14))).toString(),
      String() => parse.format(date.add(const Duration(days: 1))).toString(),
    };
  }
}





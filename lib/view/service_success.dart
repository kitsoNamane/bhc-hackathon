import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../view_model/app_state.dart';

class ServiceSuccessPage extends StatelessWidget {
  const ServiceSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Center(
        child: Consumer<ApplicationState>(
            builder: (context, state, child) => Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1
                    )
                  ),
                  child: Icon(
                    _ticketIcon(state.currentFault!.type!),
                    color: Theme.of(context).colorScheme.primary,
                    size: 64,
                  ),
                ),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        style: BorderStyle.solid,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("BHC00000${state.currentFault?.id}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Divider(thickness: 3),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Plot Number: ${state.currentFault?.plotNumber}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Divider(thickness: 1),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Type: ${state.currentFault?.type}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Divider(thickness: 1),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Incident: ${state.currentFault?.incident}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Divider(thickness: 1),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Due Date: ${_ticketDueDate(state.currentFault!.severity!, state.currentFault!.createdAt!)}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Divider(thickness: 1),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Severity: ${state.currentFault?.severity}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Divider(thickness: 1),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Status: ${state.currentFault?.status}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          )
      ),
    );
  }

  IconData _ticketIcon(String type) {
    return switch (type.toLowerCase()) {
      "electrical" => Icons.flash_off_outlined,
      "carpentry" => Icons.carpenter_outlined,
      "plumbing" => Icons.plumbing_outlined,
      "masonry" => Icons.flood_outlined,
      "mechanical" => Icons.ac_unit_outlined,
      "external" => Icons.add_business_outlined,
      String() => Icons.electric_bolt_outlined,
    };
  }

  String _ticketDueDate(String severity, String createdAt) {
    var date = DateTime.parse(createdAt);
    var parse = DateFormat("dd/MM/yyyy");
    return switch(severity) {
      "emergency" => parse.format(date.add(const Duration(days: 1))).toString(),
      "urgent" => parse.format(date.add(const Duration(days: 3))).toString(),
      "normal" => parse.format(date.add(const Duration(days: 14))).toString(),
      String() => parse.format(date.add(const Duration(days: 1))).toString(),
    };
  }
}

import 'package:bhc_hackathon/view/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/app_state.dart';


class ServiceSuccessPage extends StatefulWidget {
  const ServiceSuccessPage({super.key});

  @override
  State<StatefulWidget> createState() => _ServiceSuccessPage();
}

class _ServiceSuccessPage extends State<ServiceSuccessPage> {

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
                    UiUtil.ticketIcon(state.currentFault!.type!),
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
                            child: Text(
                              "Due Date: ${UiUtil.ticketDueDate(state.currentFault!.severity!, state.currentFault!.createdAt!)}",
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
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: state.currentFault?.status == "closed" ? _startPayment : null,
                              child: const Text("Pay"),
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

  void _startPayment() {}
}

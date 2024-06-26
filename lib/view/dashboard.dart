import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/fault.dart';
import '../view_model/app_state.dart';
import 'ui_util.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
        ),
        body: const ExistingCustomerDashboardPage(),
    );
  }
}

class ExistingCustomerDashboardPage extends StatefulWidget {
  const ExistingCustomerDashboardPage({super.key});

  @override
  State<ExistingCustomerDashboardPage> createState() => _ExistingCustomerDashboardPageState();
}

class _ExistingCustomerDashboardPageState extends State<ExistingCustomerDashboardPage> {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<ApplicationState>(context);
    if (p.faults == null) p.getCustomerFaults(p.currentUser!.uid!);
    return Center(
      child: RefreshIndicator(
          onRefresh: () async {
            await p.getCustomerFaults(p.currentUser!.uid!);
          },
          child: ListView.builder(
            itemCount: p.faults?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: ActionItem(
                    fault: p.faults![index],
                ),
                onTap: () {
                  p.goToFaultPayment(
                    p.faults![index].copyWith(status: "closed")
                  );
                },
              );
            },
          ),
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  final Fault fault;
  const ActionItem({super.key, required this.fault});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1
                  )
              ),
              child: Icon(
                UiUtil.ticketIcon(fault.type!),
                color: Theme.of(context).colorScheme.primary,
                size: 64,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text("BHC00000${fault.id!}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(thickness: 1),
                Align(
                  alignment: Alignment.topRight,
                  child: Text("Type: ${fault.type!}",
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text("Incident: ${fault.incident!}",
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Due Date: ${UiUtil.ticketDueDate(fault.severity!, fault.createdAt!)}",
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text("Severity: ${fault.severity!}",
                  ),
                ),
                const Divider(thickness: 1),
                Align(
                  alignment: Alignment.topRight,
                  child: Text("Status: ${fault.status!}",
                  ),
                ),
              ],
            ),
        ],),
      ),
    );
  }
}


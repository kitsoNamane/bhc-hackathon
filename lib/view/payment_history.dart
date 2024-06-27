import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/payment.dart';
import '../view_model/app_state.dart';
import 'ui_util.dart';

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment History"),
      ),
      body: const PaymentHistoryDashboardPage(),
    );
  }
}

class PaymentHistoryDashboardPage extends StatefulWidget {
  const PaymentHistoryDashboardPage({super.key});

  @override
  State<PaymentHistoryDashboardPage> createState() => _PaymentHistoryDashboardPageState();
}

class _PaymentHistoryDashboardPageState extends State<PaymentHistoryDashboardPage> {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<ApplicationState>(context);
    if (p.payments == null) p.getCustomerPayments(p.currentUser!.uid!);
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          await p.getCustomerFaults(p.currentUser!.uid!);
        },
        child: ListView.builder(
          itemCount: p.payments?.length ?? 0,
          itemBuilder: (context, index) {
            return ListTile(
              title: ActionItem(
                payment: p.payments![index],
              ),
              onTap: () {
              },
            );
          },
        ),
      ),
    );
  }
}
class ActionItem extends StatelessWidget {
  final Payment payment;
  const ActionItem({super.key, required this.payment});

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
                UiUtil.ticketIcon(payment.status!),
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
                  child: Text("BHC-PAY-00000${payment.id!}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(thickness: 1),
                Align(
                  alignment: Alignment.topRight,
                  child: Text("Status: ${payment.status!}",
                  ),
                ),
              ],
            ),
          ],),
      ),
    );
  }
}

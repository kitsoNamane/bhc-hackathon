import 'dart:convert';

import 'package:bhc_hackathon/model/payment.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

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
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: Center(
          child: Consumer<ApplicationState>(
            builder: (context, state, child) =>
                Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              width: 1
                          )
                      ),
                      child: Icon(
                        UiUtil.ticketIcon(state.currentFault!.type!),
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
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
                            color: Theme
                                .of(context)
                                .colorScheme
                                .primary,
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
                                child: Text("Plot Number: ${state.currentFault
                                    ?.plotNumber}",
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
                                child: Text("Incident: ${state.currentFault
                                    ?.incident}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const Divider(thickness: 1),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Due Date: ${UiUtil.ticketDueDate(
                                      state.currentFault!.severity!,
                                      state.currentFault!.createdAt!)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const Divider(thickness: 1),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Severity: ${state.currentFault
                                    ?.severity}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const Divider(thickness: 1),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Status: ${state.currentFault
                                    ?.status}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton(
                                  onPressed: state.currentFault?.status !=
                                      "closed" ? null : () async {
                                    await state.createPayment(
                                      Payment(
                                        customerId: state.currentUser?.uid,
                                        faultId: state.currentFault?.id,
                                        amount: 100000,
                                        clientSecret: "xxx-xxx-xxx",
                                      )
                                    );
                                  },
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

  Future<void> makePayment(Payment payment) async {
    try {
      // Create payment intent data
      // initialise the payment sheet setup
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Client secret key from payment data
          paymentIntentClientSecret: payment.clientSecret,
          googlePay: const PaymentSheetGooglePay(
            // Currency and country code is accourding to India
              testEnv: true,
              currencyCode: "BWP",
              merchantCountryCode: "BW"),
          // Merchant Name
          merchantDisplayName: 'BHC Hackathon',
          // return URl if you want to add
          // returnURL: 'flutterstripe://redirect',
        ),
      );
      // Display payment sheet
      displayPaymentSheet();
    } catch (e) {

      if (e is StripeConfigException) {
      } else {
      }
    }
  }

  displayPaymentSheet() async {
    try {
      // "Display payment sheet";
      await Stripe.instance.presentPaymentSheet();
      // Show when payment is done
      // Displaying snackbar for it
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Paid successfully")),
      );
      paymentIntent = null;
    } on StripeException catch (e) {
      // If any error comes during payment
      // so payment will be cancelled

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(" Payment Cancelled")),
      );
    } catch (e) {
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method': 'pm_card_visa',
      };
      var secretKey =
          "sk_test_51MLa6YG4sSRlNRRrFc2P0OH0SEAtrkaAQuUbnyHE9Ud9VqvgVqHBCwvVzv49OfYBIuW6eIrSZcKtRD5LE0w5teh200Sf9Sgiii";
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return jsonDecode(response.body.toString());
    } catch (err) {
    }
  }
}

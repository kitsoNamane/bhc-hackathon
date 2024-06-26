import 'package:bhc_hackathon/data/sqlite_crm_service.dart';
import 'package:bhc_hackathon/model/payment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/firebase_auth_service.dart';
import '../data/sql_payment_service.dart';
import '../firebase_options.dart';
import '../model/customer.dart';
import '../model/fault.dart';
import '../view/navigation_constants.dart';
import 'navigation_state.dart';

class ApplicationState extends ChangeNotifier {
  final _auth = FirebaseAuthService();
  final _crm = SqliteCRMService();
  final _navState = NavigationState();
  final _payService = SqlitePaymentService();

  ApplicationState(){
    init();
  }
  GoRouter get router => _navState.router;

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Customer? _user;
  Customer? get currentUser => _user;

  Fault? _fault;
  Fault? get currentFault => _fault;

  List<Fault>? _faults;
  List<Fault>? get faults => _faults;

  Payment? _payment;
  Payment? get currentPayment => _payment;

  List<Payment>? _payments;
  List<Payment>? get payments => _payments;

  Future<void> init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  Future<void> signIn(String email, String password) async {
    _user = await _auth.signIn(email: email, password: password);
    if (_user == null) {
      notifyListeners();
      return;
    }
    _loggedIn = true;
    notifyListeners();
    _navState.changeNavState(isExistingCustomer: _user?.isExistingCustomer ?? false);
    router.go(
      NavigationConstants.homePath,
    );
  }

  Future<void> signUp(String email, String password) async {
    _user = await _auth.signUp(email: email, password: password);
    notifyListeners();
    if (_user != null) {
      router.go(
        NavigationConstants.onboardingPath,
      );
    }
  }

  Future<void> goToFaultPayment(Fault fault) async {
    _fault = fault;
    print(_fault);
    notifyListeners();
    router.push(
      NavigationConstants.servicesSuccessPath,
    );
  }

  Future<void> onboarding(Customer customer) async {
    _user = await _auth.userOnboarding(customer: customer);
    _loggedIn = true;
    notifyListeners();
    if(_user != null) {
      _navState.changeNavState(isExistingCustomer: _user?.isExistingCustomer ?? false);
      router.go(
        NavigationConstants.homePath,
      );
    }
  }

  Future<void> getCustomerFaults(String uuid) async {
    _faults = await _crm.getCustomerFaults(uuid: uuid);
    notifyListeners();
  }

  Future<void> createFault(Fault fault) async {
    _fault = await _crm.createFault(fault: fault);
    print("##############-----------------faulitng--------------_########");
    print(_fault);
    print("##############-----------------faulitng--------------_########");
    notifyListeners();
    router.push(
      NavigationConstants.servicesSuccessPath
    );
  }

  Future<void> createPayment(Payment payment) async {
    _payment = await _payService.initiatePayment(payment: payment);
    notifyListeners();
  }

  Future<void> completePayment(Payment payment) async {
    _payment = await _payService.completePayment(payment: payment);
    if (_payment != null) {
      _fault = _fault?.copyWith(
        status: "closed",
        paymentStatus: "paid"
      );
      _faults = await _crm.getCustomerFaults(uuid: _user!.uid!);
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> getCustomerPayments(String uuid) async {
    _payments = await _payService.getCustomerPayments(uuid: uuid);
    notifyListeners();
  }

  Future<void> signOut() async {
    var isSignedOut = await _auth.signOut();
    if (isSignedOut) {
      _user = null;
      _loggedIn = false;
      notifyListeners();
      router.go(
        NavigationConstants.signInPath,
      );
    }
  }
}
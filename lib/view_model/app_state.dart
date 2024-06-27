import 'package:bhc_hackathon/data/sqlite_crm_service.dart';
import 'package:bhc_hackathon/model/payment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/firebase_auth_service.dart';
import '../data/sql_payment_service.dart';
import '../data/sqlite_auth_service.dart';
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
  final _sqliteAuthService = SqliteAuthService();

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

  String? _signUpErrorMessage;
  String? get signUpErrorMessage => _signUpErrorMessage;

  String? _signInErrorMessage;
  String? get signInErrorMessage => _signInErrorMessage;

  String? _onboardErrorMessage;
  String? get onboardErrorMessage => _onboardErrorMessage;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void restForm() {
    _signInErrorMessage = null;
    _signUpErrorMessage = null;
    _onboardErrorMessage = null;
  }

  Future<void> init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  Future<void> signIn(String email, String password) async {
    _user = await _auth.signIn(email: email, password: password);
    if (_user == null) {
      _signInErrorMessage = "Invalid sign in credentials";
      notifyListeners();
      return;
    }
    _signInErrorMessage = null;
    _loggedIn = true;
    await Posthog().identify(userId: _user!.uid!,
      userProperties: {
        "email": _user!.email!,
        "name": "${_user!.firstname} ${_user!.lastname}",
        "customer_type": _user!.isExistingCustomer! ? "existing" : "new"
      },
      userPropertiesSetOnce: {
        "date_of_first_sign_in": DateTime.now().toString()
      }
    );
    await Posthog().group(
      groupType: "customer_type",
      groupKey: _user!.isExistingCustomer! ? "existing" : "new"
    );
    await Posthog().capture(eventName: "customer_sign_in");
    notifyListeners();
    (await _prefs).setBool("isLoggedIn", true);
    (await _prefs).setString("customerUuid", _user!.uid!);
    _navState.changeNavState(isExistingCustomer: _user?.isExistingCustomer ?? false);
    router.go(
      NavigationConstants.homePath,
    );
  }

  Future<void> signUp(String email, String password) async {
    _user = await _auth.signUp(email: email, password: password);
    notifyListeners();
    if (_user != null) {
      _signUpErrorMessage = null;
      notifyListeners();
      await Posthog().identify(userId: _user!.uid!,
          userProperties: {
            "email": _user!.email!,
          },
          userPropertiesSetOnce: {
            "date_of_sign_up": DateTime.now().toString()
          }
      );
      await Posthog().capture(eventName: "customer_sign_up");
      router.go(
        NavigationConstants.onboardingPath,
      );
    } else {
      _signUpErrorMessage = "Invalid credentials, please check";
      notifyListeners();
    }

  }

  Future<void> goToFaultPayment(Fault fault) async {
    _fault = fault;
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
      await Posthog().group(
          groupType: "customer_type",
          groupKey: _user!.isExistingCustomer! ? "existing" : "new"
      );
      await Posthog().capture(eventName: "customer_onboarding");
      router.go(
        NavigationConstants.homePath,
      );
    } else {
      _onboardErrorMessage = "failed onboarding";
      notifyListeners();
    }
  }

  Future<void> getCustomerFaults(String uuid) async {
    _faults = await _crm.getCustomerFaults(uuid: uuid);
    notifyListeners();
  }

  Future<void> createFault(Fault fault) async {
    _fault = await _crm.createFault(fault: fault);
    notifyListeners();
    router.push(
      NavigationConstants.servicesSuccessPath
    );
  }

  Future<void> createPayment(Payment payment) async {
    _payment = await _payService.initiatePayment(payment: payment);
    await Posthog().capture(eventName: "payment_initiate");
    notifyListeners();
  }

  Future<void> completePayment(Payment payment) async {
    _payment = await _payService.completePayment(payment: payment);
    print(_payment);
    if (_payment != null) {
      _fault = _fault?.copyWith(
        status: _payment!.status == "success" ? "closed" : _fault!.status,
        paymentStatus: _payment!.status == "success" ? "paid" : _fault!.paymentStatus
      );
      _faults = await _crm.getCustomerFaults(uuid: _payment!.customerId!);
      await Posthog().capture(eventName: "payment_completed",
          properties: {
            "payment_id": _payment!.id.toString(),
            "customer_id": _payment!.customerId!,
            "fault_id": _payment!.faultId!,
          }
      );
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> getCustomerPayments(String uuid) async {
    _payments = await _payService.getCustomerPayments(uuid: uuid);
    notifyListeners();
  }

  Future<void> isAlreadyLoggedIn() async {
    final prefs = await _prefs;
    _loggedIn = prefs.getBool("isLoggedIn") ?? false;
    if (_loggedIn) {
      _user = await _sqliteAuthService.getCustomer(uuid: prefs.getString("customerUuid")!);
      if (_user == null) {
        router.go(
          NavigationConstants.signInPath,
        );
        notifyListeners();
      }
      _signInErrorMessage = null;
      _loggedIn = true;
      notifyListeners();
    } else {
      router.go(
        NavigationConstants.signInPath,
      );
    }
  }

  Future<void> signOut() async {
    var isSignedOut = await _auth.signOut();
    await Posthog().capture(eventName: "customer_sign_out");
    if (isSignedOut) {
      _user = null;
      _loggedIn = false;
      (await _prefs).setBool("isLoggedIn", false);
      (await _prefs).setString("customerUuid", "");
      notifyListeners();
      router.go(
        NavigationConstants.signInPath,
      );
    }
  }
}
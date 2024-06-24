import 'package:flutter/material.dart';

class NavigationConstants {
  static final GlobalKey<NavigatorState> parentNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState>  applyNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState>  dashboardNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState>  faqNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState>  paymentsNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState>  productsNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState>  profileNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState>  servicesNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState>  onboardingNavigatorKey = GlobalKey<NavigatorState>();

  static const String signUpPath = '/signUp';
  static const String signInPath = '/signIn';
  static const String resetPasswordPath = '/resetPassword';
  static const String homePath = '/home';
  static const String applyPath = '/apply';
  static const String dashboardPath = '/dashboard';
  static const String faqPath = '/faq';
  static const String paymentsPath = '/payments';
  static const String productsPath = '/products';
  static const String profilePath = '/profile';
  static const String servicesPath = '/services';
  static const String onboardingPath = '/onboarding';
}

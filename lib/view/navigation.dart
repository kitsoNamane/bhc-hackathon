import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bottom_navigation.dart';
import 'navigation_constants.dart';
import 'navigation_helpers.dart';
import 'onboarding/onboarding.dart';
import 'package:bhc_hackathon/view/company_form.dart';
import 'package:bhc_hackathon/view/individual_form.dart';
import 'package:bhc_hackathon/view/apply.dart';




class NavigationHelper {
  static final NavigationHelper _instance =
      NavigationHelper._internal();

  static NavigationHelper get instance => _instance;

  static late final GoRouter router;

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  factory NavigationHelper() {
    return _instance;
  }

  NavigationHelper._internal() {
    final routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: BottomNavigationHelpers.bottomNavigationPages(
          NavigationConstants.isNewCustomer
        ),
        pageBuilder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return getPage(
            child: BottomNavigationPage(
              child: navigationShell,
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: NavigationConstants.signUpPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const SignUpPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: NavigationConstants.signInPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const SignInPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: NavigationConstants.resetPasswordPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const ResetPasswordPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: NavigationConstants.companyHousePath, 
        pageBuilder: (context, state) {
          return getPage(
            child: const CompanyHouseForm(), 
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: NavigationConstants.individualHousePath, 
        pageBuilder: (context, state) {
          return getPage(
            child: const IndividualHouseForm(), 
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: NavigationConstants.applyPath, // Add route for rent house
        pageBuilder: (context, state) {
          return getPage(
            child: const ApplyPage(), // Helps me navigate to apply page
            state: state,
          );
        },
      ),
    ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: NavigationConstants.signInPath,
      routes: routes,
    );
  }

  get parentNavigatorKey => null;

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}
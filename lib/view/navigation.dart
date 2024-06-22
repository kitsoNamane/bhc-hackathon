import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navigation_constants.dart';
import 'navigation_helpers.dart';
import 'onboarding.dart';

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
        branches: BottomNavigationHelpers.bottomNavigationPages(false),
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

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    super.key,
    required this.child,
  });

  final StatefulNavigationShell child;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.child.currentIndex,
          onTap: (index) {
            widget.child.goBranch(
              index,
              initialLocation: index == widget.child.currentIndex,
            );
            setState(() {});
          },
          items: BottomNavigationHelpers.bottomNavigationItems(false)),
    );
  }
}




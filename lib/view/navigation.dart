import 'package:bhc_hackathon/view/dashboard.dart';
import 'package:bhc_hackathon/view/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'apply.dart';
import 'onboarding.dart';

class CustomNavigationHelper {
  static final CustomNavigationHelper _instance =
  CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> searchTabNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> settingsTabNavigatorKey =
  GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState>  applyNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState>  dashboardNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState>  faqNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState>  paymentsNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState>  productsNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState>  profileNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState>  servicesNavigatorKey =
  GlobalKey<NavigatorState>();


  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  static const String signUpPath = '/signUp';
  static const String signInPath = '/signIn';
  static const String homePath = '/home';
  static const String applyPath = '/apply';
  static const String dashboardPath = '/dashboard';
  static const String faqPath = '/faq';
  static const String paymentsPath = '/payments';
  static const String productsPath = '/products';
  static const String profilePath = '/profile';
  static const String servicesPath = '/services';

  factory CustomNavigationHelper() {
    return _instance;
  }

  CustomNavigationHelper._internal() {
    final routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: homeTabNavigatorKey,
            routes: [
              GoRoute(
                path: homePath,
                pageBuilder: (context, GoRouterState state) {
                  return getPage(
                    child: const HomePage(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: applyNavigatorKey,
            routes: [
              GoRoute(
                path: applyPath,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const ApplyPage(),
                    state: state,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: dashboardNavigatorKey,
            routes: [
              GoRoute(
                path: dashboardPath,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const DashboardPage(),
                    state: state,
                  );
                },
              ),
            ],
          ),
        ],
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
        path: signUpPath,
        pageBuilder: (context, state) {
          return getPage(
            child: const SignUpPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: signInPath,
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
      initialLocation: signInPath,
      routes: routes,
    );
  }

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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/bottom_navigation.dart';
import '../view/navigation.dart';
import '../view/navigation_constants.dart';
import '../view/navigation_helpers.dart';

class NavigationState {
  late ValueNotifier<RoutingConfig> _myRoutingConfig;
  late GoRouter _router;
  GoRouter get router => _router;
  NavigationState() {
     _myRoutingConfig = ValueNotifier<RoutingConfig>(
        RoutingConfig(
            routes: [
              StatefulShellRoute.indexedStack(
                parentNavigatorKey: NavigationConstants.parentNavigatorKey,
                branches: BottomNavigationHelpers.bottomNavigationPages(false),
                pageBuilder: (BuildContext context,
                    GoRouterState state,
                    StatefulNavigationShell navigationShell,) {
                  return NavigationHelper.getPage(
                    child: BottomNavigationPage(
                      child: navigationShell,
                    ),
                    state: state,
                  );
                },
              ),
              ...BottomNavigationHelpers.getRoutes(NavigationConstants.parentNavigatorKey),
            ]
        ));
     _router = GoRouter.routingConfig(
       routingConfig: _myRoutingConfig,
       navigatorKey: NavigationConstants.parentNavigatorKey,
       initialLocation: NavigationConstants.signInPath,
     );
  }

  void changeNavState({required bool isExistingCustomer}) {
    _myRoutingConfig.value = RoutingConfig(
        routes: [
          StatefulShellRoute.indexedStack(
            parentNavigatorKey: NavigationConstants.parentNavigatorKey,
            branches: BottomNavigationHelpers.bottomNavigationPages(isExistingCustomer),
            pageBuilder: (BuildContext context,
                GoRouterState state,
                StatefulNavigationShell navigationShell,) {
              return NavigationHelper.getPage(
                child: BottomNavigationPage(
                  child: navigationShell,
                ),
                state: state,
              );
            },
          ),
          ...BottomNavigationHelpers.getRoutes(NavigationConstants.parentNavigatorKey),
        ]
    );
  }
}
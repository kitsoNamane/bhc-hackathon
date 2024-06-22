import 'package:bhc_hackathon/view/faq.dart';
import 'package:bhc_hackathon/view/payments.dart';
import 'package:bhc_hackathon/view/products.dart';
import 'package:bhc_hackathon/view/profile.dart';
import 'package:bhc_hackathon/view/services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'apply.dart';
import 'home.dart';
import 'navigation.dart';
import 'navigation_constants.dart';

class BottomNavigationHelpers {

  static List<BottomNavigationBarItem> bottomNavigationItems(bool isNewCustomer) {
    if (isNewCustomer) {
      return const [
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'products',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.app_registration),
          label: 'apply',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.question_mark_rounded),
          label: 'FAQs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'profile',
        ),
      ];
    }

    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        label: 'dashboard',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.design_services),
        label: 'services',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: 'products',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.receipt_long),
        label: 'payment history',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: 'profile',
      ),
    ];
  }

  static List<StatefulShellBranch> bottomNavigationPages(bool isNewCustomer) {
    if (isNewCustomer) {
      return [
        StatefulShellBranch(
          navigatorKey: NavigationConstants.homeTabNavigatorKey,
          routes: [
            GoRoute(
              path: NavigationConstants.homePath,
              pageBuilder: (context, GoRouterState state) {
                return NavigationHelper.getPage(
                  child: const HomePage(),
                  state: state,
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: NavigationConstants.dashboardNavigatorKey,
          routes: [
            GoRoute(
              path: NavigationConstants.dashboardPath,
              pageBuilder: (context, state) {
                return NavigationHelper.getPage(
                  child: const ApplyPage(),
                  state: state,
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: NavigationConstants.faqNavigatorKey,
          routes: [
            GoRoute(
              path: NavigationConstants.faqPath,
              pageBuilder: (context, state) {
                return NavigationHelper.getPage(
                  child: const FAQPage(),
                  state: state,
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: NavigationConstants.profileNavigatorKey,
          routes: [
            GoRoute(
              path: NavigationConstants.profilePath,
              pageBuilder: (context, state) {
                return NavigationHelper.getPage(
                  child: const ProfilePage(),
                  state: state,
                );
              },
            ),
          ],
        ),
      ];
    }

    return [
      StatefulShellBranch(
        navigatorKey: NavigationConstants.homeTabNavigatorKey,
        routes: [
          GoRoute(
            path: NavigationConstants.homePath,
            pageBuilder: (context, GoRouterState state) {
              return NavigationHelper.getPage(
                child: const HomePage(),
                state: state,
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: NavigationConstants.applyNavigatorKey,
        routes: [
          GoRoute(
            path: NavigationConstants.applyPath,
            pageBuilder: (context, state) {
              return NavigationHelper.getPage(
                child: const ServicesPage(),
                state: state,
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: NavigationConstants.dashboardNavigatorKey,
        routes: [
          GoRoute(
            path: NavigationConstants.dashboardPath,
            pageBuilder: (context, state) {
              return NavigationHelper.getPage(
                child: const ProductsPage(),
                state: state,
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: NavigationConstants.paymentsNavigatorKey,
        routes: [
          GoRoute(
            path: NavigationConstants.paymentsPath,
            pageBuilder: (context, state) {
              return NavigationHelper.getPage(
                child: const PaymentsPage(),
                state: state,
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: NavigationConstants.profileNavigatorKey,
        routes: [
          GoRoute(
            path: NavigationConstants.profilePath,
            pageBuilder: (context, state) {
              return NavigationHelper.getPage(
                child: const ProfilePage(),
                state: state,
              );
            },
          ),
        ],
      ),
    ];
  }
}
import 'package:bhc_hackathon/view/company_form.dart';
import 'package:bhc_hackathon/view/dashboard.dart';
import 'package:bhc_hackathon/view/faq.dart';
import 'package:bhc_hackathon/view/individual_form.dart';
import 'package:bhc_hackathon/view/payment.dart';
import 'package:bhc_hackathon/view/payment_history.dart';
import 'package:bhc_hackathon/view/products.dart';
import 'package:bhc_hackathon/view/profile.dart';
import 'package:bhc_hackathon/view/service_success.dart';
import 'package:bhc_hackathon/view/services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'apply.dart';
import 'home.dart';
import 'navigation.dart';
import 'navigation_constants.dart';
import 'onboarding/onboarding.dart';

class BottomNavigationHelpers {

  static List<BottomNavigationBarItem> bottomNavigationItems(bool isExistingCustomer) {
    if (isExistingCustomer) {
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

  static List<StatefulShellBranch> bottomNavigationPages(bool isExistingCustomer) {
    if (isExistingCustomer) {
      return [
        StatefulShellBranch(
          navigatorKey: NavigationConstants.dashboardNavigatorKey,
          routes: [
            GoRoute(
              path: NavigationConstants.homePath,
              pageBuilder: (context, GoRouterState state) {
                return NavigationHelper.getPage(
                  child: const DashboardPage(),
                  state: state,
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: NavigationConstants.servicesNavigatorKey,
          routes: [
            GoRoute(
              path: NavigationConstants.servicesPath,
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
          navigatorKey: NavigationConstants.productsNavigatorKey,
          routes: [
            GoRoute(
              path: NavigationConstants.productsPath,
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
          navigatorKey: NavigationConstants.paymentsHistoryNavigatorKey,
          routes: [
            GoRoute(
              path: NavigationConstants.paymentsHistoryPath,
              pageBuilder: (context, state) {
                return NavigationHelper.getPage(
                  child: const PaymentHistoryPage(),
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
        navigatorKey: NavigationConstants.homeNavigatorKey,
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

  static List<GoRoute> getRoutes(GlobalKey<NavigatorState> parentKey) {
    return [
      GoRoute(
        parentNavigatorKey: parentKey,
        path: NavigationConstants.signUpPath,
        pageBuilder: (context, state) {
          return NavigationHelper.getPage(
            child: const SignUpPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentKey,
        path: NavigationConstants.signInPath,
        pageBuilder: (context, state) {
          return NavigationHelper.getPage(
            child: const SignInPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentKey,
        path: NavigationConstants.resetPasswordPath,
        pageBuilder: (context, state) {
          return NavigationHelper.getPage(
            child: const ResetPasswordPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentKey,
        path: NavigationConstants.onboardingPath,
        pageBuilder: (context, state) {
          return NavigationHelper.getPage(
            child: const CustomerOnboarding(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentKey,
        path: NavigationConstants.servicesSuccessPath,
        pageBuilder: (context, state) {
          return NavigationHelper.getPage(
            child: const ServiceSuccessPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentKey,
        path: NavigationConstants.paymentsPath,
        pageBuilder: (context, state) {
          return NavigationHelper.getPage(
            child: const Payments(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentKey,
        path: NavigationConstants.individualHousePath,
        pageBuilder: (context, state) {
          return NavigationHelper.getPage(
            child: const IndividualHouseForm(),
            state: state,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: parentKey,
        path: NavigationConstants.companyHousePath,
        pageBuilder: (context, state) {
          return NavigationHelper.getPage(
            child: const CompanyHouseForm(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: NavigationConstants.faqsPath,
        pageBuilder: (context, state) {
          return NavigationHelper.getPage(
            child: const FAQPage(),
            state: state,
          );
        },
      ),
    ];
  }
}
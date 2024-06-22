import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'view/navigation.dart';

main() {
  CustomNavigationHelper.instance;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: CustomNavigationHelper.router,
    );
  }
}
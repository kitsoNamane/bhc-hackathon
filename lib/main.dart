import 'package:flutter/material.dart';

import 'view/navigation.dart';

main() {
  NavigationHelper.instance;
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: NavigationHelper.router,
    );
  }
}
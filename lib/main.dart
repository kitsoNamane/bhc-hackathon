import 'package:bhc_hackathon/view_model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/navigation.dart';

main() {
  runApp(
      ChangeNotifierProvider(
          create: (context) => ApplicationState(),
          child: const App(),
      )
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<ApplicationState>(context);
    print("##############################");
    print(p.loggedIn);
    print("##############################");
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: p.router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
    );
  }
}
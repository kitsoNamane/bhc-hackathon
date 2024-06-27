import 'package:bhc_hackathon/view_model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
  'pk_test_51MLa6YG4sSRlNRRrfUDVug1S2AiWahvQ4b0vWuGcxdUtWwun2M0FdvapRGAOBdnvXUBSkrdegC6ZjfiFbZ2AI3dk00xTwnW20y';
  SharedPreferences.setMockInitialValues({});
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: p.router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(173, 38, 36, 1.0)),
        useMaterial3: true,
      ),
    );
  }
}
import 'package:bhc_hackathon/view_model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
  'pk_test_51MLa6YG4sSRlNRRrfUDVug1S2AiWahvQ4b0vWuGcxdUtWwun2M0FdvapRGAOBdnvXUBSkrdegC6ZjfiFbZ2AI3dk00xTwnW20y';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
    );
  }
}
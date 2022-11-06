import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/appstate/appstate.dart';
import 'core/provider/provider.dart';
import 'core/routing/routing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appState = await AppState.appInitialize();

  runApp(
    MultiProvider(
      providers: Providers.getFromAppState(appState),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: Provider.of<Routing>(context, listen: false).goRouter,
    );
  }
}

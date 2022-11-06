import 'package:provider/provider.dart';
import '../appstate/models/app_state_model.dart';
import '../autentication/auth_provider.dart';
import '../routing/routing.dart';

class Providers {
  static getFromAppState(AppStateModel app) => [
        ListenableProvider<AuthProvider>(
          create: (context) => app.authProvider,
          dispose: (context, provider) => provider.dispose(),
        ),
        Provider<Routing>(
          lazy: false,
          create: (ctx) => Routing(app),
          dispose: (context, provider) => provider.dispose(),
        ),
      ];
}

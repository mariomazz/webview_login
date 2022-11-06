import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import '../autentication/auth_provider.dart';
import '../autentication/configurations/authentication_configurations.dart';
import 'models/app_state_model.dart';

class AppState {
  static Future<AppStateModel> appInitialize() async {
    setPathUrlStrategy();
    final authProvider = await AuthProvider.initAndLoadSession(
      configurations: AuthenticationConfigurations.withENV(),
      storage: SharedPreferences.getInstance(),
      storageKey: "csuifiuweifgwegy",
      onChange: (provider, loginData) async {},
    );

    return AppStateModel(authProvider);
  }
}

import '../../autentication/auth_provider.dart';

class AppStateModel {
  final AuthProvider authProvider;

  AppStateModel(
    this.authProvider,
  );
  void dispose() {
    authProvider.dispose();
  }
}

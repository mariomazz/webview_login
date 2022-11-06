import 'package:flutter/material.dart';
import 'package:platforms_auth_service/platforms_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../jwt_manager/jwt_manager.dart';
import 'models/common.dart';

class AuthProvider with ChangeNotifier {
  static Future<AuthProvider> initAndLoadSession({
    required AuthConfigurations configurations,
    Future<void> Function(AuthProvider provider, AuthUserData data)? onChange,
    required String storageKey,
    required Future<SharedPreferences> storage,
  }) async {
    final instance = AuthProvider(
      configurations: configurations,
      dbLoginKey: storageKey,
      session: _sessionNull,
      storage: storage,
    );
    final session = await instance.loadSession();
    instance.session = session;
    return instance;
  }

  final AuthConfigurations configurations;

  final Future<void> Function(AuthProvider provider, AuthUserData data)?
      onChange;

  final Future<SharedPreferences> storage;

  late final _authService = AuthService(
    logOutPrompt: true,
    enableLog: true,
    configurations: configurations,
    storageInstance: storage,
    authDbKey: dbLoginKey,
  );

  static final _sessionNull = AuthUserData(
    authData: AuthData(isAuth: false),
    userData: UserData(),
  );

  bool get currentIsAuth => session.authData.isAuth;

  String? get currentAccessToken => session.authData.accessToken;

  AuthUserData session;

  final String dbLoginKey;

  bool? isAuthorized;

  AuthProvider({
    required this.configurations,
    this.onChange,
    required this.storage,
    required this.session,
    required this.dbLoginKey,
    this.isAuthorized,
  });

  Future<AuthUserData> loadSession() async {
    try {
      final loginData = await _authService.getTokensSaved();
      final String accessToken = loginData.accessToken;
      final auth = AuthData(
        isAuth: true,
        accessToken: accessToken,
      );
      return AuthUserData.from(
        authData: auth,
        userData: _getUserData(accessToken),
      );
    } catch (e) {
      return _sessionNull;
    }
  }

  Future<void> refreshSession() async {
    try {
      final authData = await _authService.refreshSession();
      final accessToken = authData.accessToken;
      final refreshData = AuthUserData.from(
        authData: authData,
        userData: accessToken != null ? _getUserData(accessToken) : UserData(),
      );
      _setSession(refreshData);
      _setAuthorization(true);
      await onChange?.call(this, refreshData);
      _updateUI();
      return;
    } catch (e) {
      return;
    }
  }

  Future<void> login() async {
    final authData = await _authService.login();
    final accessToken = authData.accessToken;
    final loginData = AuthUserData.from(
      authData: authData,
      userData: accessToken != null ? _getUserData(accessToken) : UserData(),
    );
    _setSession(loginData);
    _setAuthorization(true);
    await onChange?.call(this, loginData);
    _updateUI();
  }

  Future<void> logout() async {
    await _authService.logout();
    _setSession(_sessionNull);
    _setAuthorization(null);
    await onChange?.call(this, _sessionNull);
    _updateUI();
  }

  void setAuthorization(bool? authorized) {
    _setAuthorization(authorized, notify: true);
  }

  void _setAuthorization(bool? authorized, {bool notify = false}) {
    isAuthorized = authorized;
    if (notify) {
      _updateUI();
    }
  }

  void _setSession(AuthUserData data, {bool notify = false}) {
    session = data;
    if (notify) {
      _updateUI();
    }
  }

  UserData _getUserData(String accessToken) {
    final JwtManager jwt = JwtManager();
    return UserData.fromMap(jwt.decodeJWT(accessToken));
  }

  void _updateUI() {
    notifyListeners();
  }

  Future<void> authStatusChange() async {
    if (currentIsAuth) {
      return await logout();
    }
    return await login();
  }
}

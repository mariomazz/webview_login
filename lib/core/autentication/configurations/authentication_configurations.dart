import 'package:platforms_auth_service/core/models/auth_configurations.dart';

class AuthenticationConfigurations {
  static const String _redirectUrl = "http://localhost:53869/auth.html";
  static const String _postLogoutRedirectUrl = "http://localhost:53869/auth.html";
  static AuthConfigurations withENV() => AuthConfigurations(
        clientId: 'porticomobileclient',
        tenantId: 'e5283a46-4b45-4cc6-864a-74063f8cc7b5',
        redirectUrl: _redirectUrl,
        issuer:
            'https://login-dev.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5',
        discoveryUrl:
            'https://login-dev.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/.well-known/openid-configuration',
        postLogoutRedirectUrl: _postLogoutRedirectUrl,
        authorizationEndpoint:
            'https://login-dev.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/authorize',
        tokenEndpoint:
            'https://login-dev.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/token',
        endSessionEndpoint:
            'https://login-dev.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/endsession',
        additionalParameter: {
          'authorityId': '6',
        },
        scopes: [
          'asfappusers',
          'openid',
          'profile',
          'roles',
          'offline_access',
          'api',
          'asfappcore',
          'asfappprofile'
        ],
        clientSecret: "secret",
        promptValues: ["login"],
        state: _postLogoutRedirectUrl,
      );
}

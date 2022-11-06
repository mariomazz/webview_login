import 'package:extension_methods/core/listenable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import '../../ui/screens/home.dart';
import '../../ui/screens/login.dart';
import '../../ui/screens/user_detail.dart';
import '../appstate/models/app_state_model.dart';
import 'configurations/navigation_transitions.dart';
import 'configurations/routes.dart';

class Routing {
  final AppStateModel app;

  Routing(this.app);
  final defaultWidget = const SizedBox();

  late final goRouter = GoRouter(
    initialLocation: Routes.initialRoute,
    errorPageBuilder: (ctx, state) {
      return NavigationTransitions.base(ctx, state, const SizedBox());
    },
    errorBuilder: (ctx, state) {
      return defaultWidget;
    },
    debugLogDiagnostics: true,
    redirect: (ctx, state) {
      final currentLocation = state.location;
      const baseLocation = Routes.initialRoute;
      const loginPath = Routes.login;
      final currentIsloginLoc = currentLocation == loginPath;
      final redirectToLogin =
          _userIsNotAuthenticated && currentIsloginLoc == false;
      final removeLoginLoc =
          _userIsNotAuthenticated == false && currentIsloginLoc;

      if (redirectToLogin) {
        return loginPath;
      }

      if (removeLoginLoc) {
        return baseLocation;
      }

      return null;
    },
    observers: [NavigationHistoryObserver()],
    refreshListenable: ListenableExtension.fromMulti([app.authProvider]),
    routes: [
      GoRoute(
        path: Routes.initialRoute,
        redirect: (ctx, state) => Routes.home,
      ),
      GoRoute(
        path: Routes.home,
        pageBuilder: (ctx, state) {
          return NavigationTransitions.base(ctx, state, const Home());
        },
        routes: [
          GoRoute(
            path: ":id",
            pageBuilder: (ctx, state) {
              return NavigationTransitions.base(
                ctx,
                state,
                UserDetailPage(userId: state.params['id'] ?? ''),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: Routes.login,
        pageBuilder: (ctx, state) {
          return NavigationTransitions.base(ctx, state, const Login());
        },
      ),
    ],
  );

  void dispose() {
    return goRouter.dispose();
  }

  bool get _userIsNotAuthenticated {
    return app.authProvider.currentIsAuth == false;
  }
}

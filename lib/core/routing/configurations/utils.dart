import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

extension ExtGoRouter on GoRouter {
  void securePush(String location, {Object? extra}) {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (NavigationHistoryObserver().top?.settings.name != location) {
        return push(location, extra: extra);
      }
    });
  }

  void secureGo(String location, {Object? extra}) {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (NavigationHistoryObserver().top?.settings.name != location) {
        return go(location, extra: extra);
      }
    });
  }

  void secureGoNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) {
    Future.delayed(const Duration(milliseconds: 150), () {
      final loc = namedLocation(name, params: params, queryParams: queryParams);
      if (NavigationHistoryObserver().top?.settings.name != loc) {
        return go(loc, extra: extra);
      }
    });
  }

  void securePushNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) {
    Future.delayed(const Duration(milliseconds: 150), () {
      final loc = namedLocation(name, params: params, queryParams: queryParams);
      if (NavigationHistoryObserver().top?.settings.name != loc) {
        return pushNamed(loc, extra: extra);
      }
    });
  }
}

extension ExtBuildContext on BuildContext {
  void securePush(String location, {Object? extra}) {
    return GoRouter.of(this).securePush(location, extra: extra);
  }

  void secureGo(String location, {Object? extra}) {
    return GoRouter.of(this).secureGo(location, extra: extra);
  }

  void secureGoNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) {
    return GoRouter.of(this).secureGoNamed(name,
        params: params, queryParams: queryParams, extra: extra);
  }

  void securePushNamed(
    String name, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic> queryParams = const <String, dynamic>{},
    Object? extra,
  }) {
    return GoRouter.of(this).securePushNamed(name,
        params: params, queryParams: queryParams, extra: extra);
  }
}

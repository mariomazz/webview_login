import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationTransitions {
  static CustomTransitionPage<T> base<T>(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          child,
      maintainState: false,
      transitionDuration: Duration.zero,
    );
  }

  static CustomTransitionPage<T> fade<T>(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      maintainState: false,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}

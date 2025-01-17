import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:short_notes/Pages/home.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) {
          return Home();
        },
      )
    ],
  );
}

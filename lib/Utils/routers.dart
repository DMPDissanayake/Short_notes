import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:short_notes/Pages/home.dart';
import 'package:short_notes/Pages/note_page.dart';
import 'package:short_notes/Pages/todo_page.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: [
      //Home
      GoRoute(
        path: "/",
        builder: (context, state) {
          return Home();
        },
      ),
      //Nots
      GoRoute(
        name: "notes",
        path: "/notes",
        builder: (context, state) {
          return NotePage();
        },
      ),
      //Todo
      GoRoute(
        name: "todo",
        path: "/todos",
        builder: (context, state) {
          return ToDoPapp();
        },
      ),
    ],
  );
}

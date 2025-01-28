import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:short_notes/Pages/create_note.dart';
import 'package:short_notes/Pages/home.dart';
import 'package:short_notes/Pages/note_page.dart';
import 'package:short_notes/Pages/notes_by_catagory.dart';
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
      //note catagory page
      GoRoute(
        path: "/catagory",
        builder: (context, state) {
          final String catagory = state.extra as String;
          return NotesByCatagory(catagory: catagory);
        },
      ),
      //create note page
      GoRoute(
        name: "create-note",
        path: "/create-note",
        builder: (context, state) {
          final isNewCatagoryPage = state.extra as bool;
          return CreateNote(isNewNote: isNewCatagoryPage);
        },
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:short_notes/Models/note_model.dart';
import 'package:short_notes/Pages/create_note.dart';
import 'package:short_notes/Pages/home.dart';
import 'package:short_notes/Pages/note_page.dart';
import 'package:short_notes/Pages/notes_by_catagory.dart';
import 'package:short_notes/Pages/singe_note_page.dart';
import 'package:short_notes/Pages/todo_page.dart';
import 'package:short_notes/Pages/update_note.dart';

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
      //Edit note
      GoRoute(
        name: "edit page",
        path: "/edit-note",
        builder: (context, state) {
          final Note newNot = state.extra as Note;
          return UpdateNotePage(note: newNot);
        },
      ),
      //singel note page
      GoRoute(
        name: "singelnote",
        path: "/singel-note",
        builder: (context, state) {
          final Note setNote = state.extra as Note;
          return SingeNotePage(note: setNote);
        },
      )
    ],
  );
}

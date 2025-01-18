import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:short_notes/Models/note_model.dart';
import 'package:short_notes/Models/todo_model.dart';
import 'package:short_notes/Utils/routers.dart';
import 'package:short_notes/Utils/theme_data.dart';

void main() async {
  //ininalize hive
  await Hive.initFlutter();

  //Register the adapters
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TodoAdapter());

  //open hive box
  await Hive.openBox('notes');
  await Hive.openBox('todos');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "NoteSphere",
      theme: ThemeClass.darkTheme.copyWith(
        textTheme: GoogleFonts.dmSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}

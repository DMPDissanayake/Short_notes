import 'package:flutter/material.dart';
import 'package:short_notes/Models/note_model.dart';
import 'package:short_notes/Services/note_service.dart';
import 'package:short_notes/Utils/constant.dart';
import 'package:short_notes/Utils/routers.dart';
import 'package:short_notes/Utils/text_style.dart';
import 'package:short_notes/Widgets/nots_todo_crad.dart';
import 'package:short_notes/Widgets/progress_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NotService notService = NotService();
  List<Note> allNote = [];

  //load list
  Future<void> _loadNotes() async {
    final List<Note> loadedNote = await notService.loadNotes();
    setState(() {
      allNote = loadedNote;
    });
  }

  @override
  void initState() {
    _loadNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NoteSphere",
          style: AppTextStyles.appTitle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: AppConstants.kDefaultPadding,
            ),
            ProgressCard(
              completTask: 3,
              totalCompletTask: 5,
            ),
            SizedBox(
              height: AppConstants.kDefaultPadding * 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/notes");
                  },
                  child: NotsTodoCrad(
                    icon: Icons.bookmark_add_outlined,
                    title: 'Notes',
                    description: "${allNote.length.toString()} Notes",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/todos");
                  },
                  child: NotsTodoCrad(
                    icon: Icons.today_outlined,
                    title: 'To-Do List',
                    description: '3 Tasks',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppConstants.kDefaultPadding * 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Progress",
                  style: AppTextStyles.appSubtitle,
                ),
                Text(
                  "See All",
                  style: AppTextStyles.appSubtitle,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

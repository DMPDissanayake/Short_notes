import 'package:flutter/material.dart';
import 'package:short_notes/Models/note_model.dart';
import 'package:short_notes/Services/note_service.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/constant.dart';
import 'package:short_notes/Utils/routers.dart';
import 'package:short_notes/Utils/text_style.dart';
import 'package:short_notes/Widgets/notes_card.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final NotService notService = NotService();
  List<Note> allNotes = [];
  Map<String, List<Note>> noteWithCatagory = {};

  @override
  void initState() {
    super.initState();
    _checkIfUserIsnote();
  }

  //check the new user
  void _checkIfUserIsnote() async {
    final bool isNewUser = await notService.isNewUser();
    //if the user is new and create the inital notes
    if (isNewUser) {
      await notService.createInitialNotes();
    }
    //load the notes
    _loadNotes();
  }

  //load the notes
  Future<void> _loadNotes() async {
    final List<Note> loadeNotes = await notService.loadNotes();
    final Map<String, List<Note>> notByCatagory =
        notService.getNotesByCatagoryMap(loadeNotes);
    setState(() {
      allNotes = loadeNotes;
      noteWithCatagory = notByCatagory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: AppColors.kWhiteColor,
          ),
          onPressed: () {
            AppRouter.router.go("/");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
            side: BorderSide(
              color: AppColors.kWhiteColor,
              width: 2,
            )),
        backgroundColor: AppColors.kFabColor,
        child: Icon(
          Icons.add,
          color: AppColors.kWhiteColor,
          size: 30,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nots",
              style: AppTextStyles.appTitle,
            ),
            SizedBox(
              height: 30,
            ),
            allNotes.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: Text(
                        "no Notes are available , plases cjick the  + button to add a New note",
                        style: AppTextStyles.appDescription,
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppConstants.kDefaultPadding,
                      mainAxisSpacing: AppConstants.kDefaultPadding,
                      childAspectRatio: 6 / 4,
                    ),
                    itemCount: noteWithCatagory.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          AppRouter.router.push(
                            "/catagory",
                            extra: noteWithCatagory.keys.elementAt(index),
                          );
                        },
                        child: NotesCard(
                          catecatagory: noteWithCatagory.keys.elementAt(index),
                          noOfNotes:
                              noteWithCatagory.values.elementAt(index).length,
                        ),
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}

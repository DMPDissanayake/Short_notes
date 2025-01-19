import 'package:flutter/material.dart';
import 'package:short_notes/Models/note_model.dart';
import 'package:short_notes/Services/note_service.dart';
import 'package:short_notes/Utils/colors.dart';
import 'package:short_notes/Utils/constant.dart';
import 'package:short_notes/Utils/routers.dart';
import 'package:short_notes/Utils/text_style.dart';
import 'package:short_notes/Widgets/note_catagory_card.dart';

class NotesByCatagory extends StatefulWidget {
  final String catagory;
  const NotesByCatagory({
    super.key,
    required this.catagory,
  });

  @override
  State<NotesByCatagory> createState() => _NotesByCatagoryState();
}

class _NotesByCatagoryState extends State<NotesByCatagory> {
  final NotService notService = NotService();
  List<Note> noteList = [];

  @override
  void initState() {
    super.initState();
    _loadNotesByCatagory();
  }

  //load all notes by catagory
  Future<void> _loadNotesByCatagory() async {
    noteList = await notService.getNotesByCategory(widget.catagory);
    setState(() {});
  }

  //Edite
  void _editNotes(Note note) {
    //navigate to the edit note page
  }

  //Delete Note
  Future<void> _removeNotes(String id) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: AppColors.kWhiteColor,
          ),
          onPressed: () {
            AppRouter.router.go("/notes");
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                widget.catagory,
                style: AppTextStyles.appSubtitle,
              ),
              SizedBox(
                height: 30,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppConstants.kDefaultPadding,
                  mainAxisSpacing: AppConstants.kDefaultPadding,
                  childAspectRatio: 7 / 11,
                ),
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  return NoteCatagoryCard(
                    title: noteList[index].title,
                    description: noteList[index].content,
                    editNote: () async {},
                    removeNote: () async {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

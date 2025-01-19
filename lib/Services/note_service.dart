import 'package:hive/hive.dart';
import 'package:short_notes/Models/note_model.dart';
import 'package:uuid/uuid.dart';

class NotService {
  List<Note> allNotes = [
    Note(
      id: const Uuid().v4(),
      title: "Meeting Notes",
      category: "Work",
      content:
          "Discussed project deadlines and deliverables. Assigned tasks to team members and set up follow-up meetings to track progress.",
      date: DateTime.now(),
    ),
    Note(
      id: const Uuid().v4(),
      title: "Grocery List",
      category: "Personal",
      content:
          "Bought milk, eggs, bread, fruits, and vegetables from the local grocery store. Also added some snacks for the week.",
      date: DateTime.now(),
    ),
    Note(
      id: const Uuid().v4(),
      title: "Book Recommendations",
      category: "Hobby",
      content:
          "Recently read 'Sapiens' by Yuval Noah Harari, which offered fascinating insights into the history of humankind. Also enjoyed 'Atomic Habits' by James Clear, a practical guide to building good habits and breaking bad ones.",
      date: DateTime.now(),
    ),
  ];

  // Create the database reference for notes
  final _myBox = Hive.box("notes");

  //check weather the user is new user
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  // Method to create the initial notes if the box is empty
  Future<void> createInitialNotes() async {
    if (_myBox.isEmpty) {
      await _myBox.put("notes", allNotes);
    }
  }

  // Method to load the notes
  Future<List<Note>> loadNotes() async {
    final dynamic notes = await _myBox.get("notes");
    if (notes != null && notes is List<dynamic>) {
      return notes.cast<Note>().toList();
    }
    return [];
  }

  //loop througn all notes and create an object where the key is the category and the value is the notes in that category
  Map<String, List<Note>> getNotesByCatagoryMap(List<Note> allNotes) {
    final Map<String, List<Note>> notesByCatogory = {};

    for (final note in allNotes) {
      if (notesByCatogory.containsKey(note.category)) {
        notesByCatogory[note.category]!.add(note);
      } else {
        notesByCatogory[note.category] = [note];
      }
    }
    return notesByCatogory;
  }

  // Method to get the notes according to the category
  Future<List<Note>> getNotesByCategory(String category) async {
    //get all notes from the box
    final dynamic allNotes = await _myBox.get("notes");
    final List<Note> notes = [];
    for (final note in allNotes) {
      if (note.category == category) {
        notes.add(note);
      }
    }

    return notes;
  }

  //Method for Edit
  Future<void> updateNote(Note note) async {
    try {
      final dynamic allNotes = await _myBox.get("notes");
      final int index = allNotes.indexWhere((element) => element.id == note.id);
      allNotes[index] = note;
      await _myBox.put("notes", allNotes);
    } catch (e) {
      e.toString();
    }
  }

  //Method for Delete
  Future<void> deleteNotes(Note noteId) async {
    try {
      final dynamic allNotes = await _myBox.get("notes");
      allNotes.removeWhere((element) => element.id == noteId);
      await _myBox.put("notes", allNotes);
    } catch (e) {
      e.toString();
    }
  }
}

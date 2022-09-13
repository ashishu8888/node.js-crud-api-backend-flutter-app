import 'package:flutter/cupertino.dart';
import 'package:notes_app/model/modal.dart';
import 'package:notes_app/services/api_services.dart';

class NotesProvider with ChangeNotifier {
  NotesProvider() {
    getNotes();
  }
  List<NoteModel> notes = [];
  void sortNotes() {
    notes.sort((a, b) => a.dateadded!.compareTo(b.dateadded!));
  }

  bool isLoad = true;
  Future<void> getNotes() async {
    final userid = {"userid": "au@gmail.com"};
    final res = await ApiService.getNotes(userid);
    // print(res.length);
    for (var note in res) {
      notes.add(note);
    }
    sortNotes();
    //notes.add(note);
    isLoad = false;
    notifyListeners();
    //print(note.toMap());
  }

  Future<void> addNote(NoteModel note) async {
    notes.add(note);
    sortNotes();
    notifyListeners();
    print(note.toMap());
    await ApiService.addNote(note);
  }

  void updateNote(NoteModel note) async {
    int indexOf =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOf] = note;
    notifyListeners();
    await ApiService.updateNote(notes[indexOf]);
  }

  void deleteNote(NoteModel note) async {
    int indexOf =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOf);
    notifyListeners();
    await ApiService.deleteNote(note);
  }
}

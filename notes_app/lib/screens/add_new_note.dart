import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/model/modal.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNote extends StatefulWidget {
  NoteModel? note;
  bool isUpdate;
  AddNewNote({super.key, required this.isUpdate, this.note});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  TextEditingController titleCtr = TextEditingController();

  TextEditingController noteCtr = TextEditingController();

  FocusNode focusNote = FocusNode();

  bool isLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.note != null) {
      titleCtr.text = widget.note!.title!;
      noteCtr.text = widget.note!.content!;
    }
  }

  Future addNote(BuildContext context) async {
    setState(() {
      isLoad = true;
    });
    final note = NoteModel(
      id: const Uuid().v1(),
      userid: "au@gmail.com",
      title: titleCtr.text,
      content: noteCtr.text,
      dateadded: DateFormat().add_MMMd().format(
            DateTime.now(),
          ),
    );
    await Provider.of<NotesProvider>(context, listen: false).addNote(note);
    setState(() {
      isLoad = false;
    });
    print('done');
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('notes added'),
      ),
    );
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xf43a09).withOpacity(0.8),
        actions: [
          (!isLoad)
              ? IconButton(
                  onPressed: () {
                    if (!widget.isUpdate) {
                      addNote(context);
                    } else {
                      widget.note!.title = titleCtr.text;
                      widget.note!.content = noteCtr.text;
                      Provider.of<NotesProvider>(context, listen: false)
                          .updateNote(widget.note!);
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.done_rounded),
                )
              : const CupertinoActivityIndicator(),
        ],
        title: Text(
          'Add a new Note',
          style: GoogleFonts.lato(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              autofocus: widget.isUpdate ? false : true,
              style: GoogleFonts.lato(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              controller: titleCtr,
              decoration: const InputDecoration(
                hintText: "title",
                border: InputBorder.none,
              ),
              onSubmitted: (val) {
                if (val != "") {
                  focusNote.requestFocus();
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: TextField(
                focusNode: focusNote,
                style: GoogleFonts.lato(
                  fontSize: 15,
                  color: Colors.black,
                ),
                controller: noteCtr,
                maxLines: null,
                decoration: const InputDecoration(
                  fillColor: Color.fromARGB(255, 158, 21, 21),
                  hintText: "add a note...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

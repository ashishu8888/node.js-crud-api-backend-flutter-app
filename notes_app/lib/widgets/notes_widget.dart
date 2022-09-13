import 'package:flutter/material.dart';
import 'package:notes_app/model/modal.dart';

class NotesWidget extends StatefulWidget {
  NoteModel? notesModel;
  NotesWidget({super.key, required this.notesModel});

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Text(widget.notesModel!.title!),
      ],
    ));
  }
}

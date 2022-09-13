import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/screens/add_new_note.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoad = true;
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    //notesProvider.getNotes();
    //print("hello");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xf43a09).withOpacity(0.8),
        title: Text(
          'your notes',
          style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: (notesProvider.isLoad == false)
          ? SafeArea(
              child: (notesProvider.notes.isNotEmpty)
                  ? GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: notesProvider.notes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => AddNewNote(
                                  isUpdate: true,
                                  note: notesProvider.notes[index],
                                ),
                              ),
                            );
                          },
                          onLongPress: () {
                            notesProvider
                                .deleteNote(notesProvider.notes[index]);
                          },
                          child: Card(
                            elevation: 5,
                            margin: const EdgeInsets.all(8),
                            color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)]
                                .withOpacity(0.5),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    notesProvider.notes[index].dateadded!,
                                    style: GoogleFonts.actor(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Wrap(
                                    direction: Axis.vertical,
                                    children: [
                                      Text(
                                        notesProvider.notes[index].title!,
                                        style: GoogleFonts.lato(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        notesProvider.notes[index].content!,
                                        style: GoogleFonts.lato(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                        ),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No notes yet',
                        style: GoogleFonts.actor(
                            fontSize: 30,
                            color: Colors.black45,
                            fontWeight: FontWeight.w300),
                      ),
                    ))
          : Center(
              child: CupertinoActivityIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xf43a09).withOpacity(0.8),
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => AddNewNote(
                isUpdate: false,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

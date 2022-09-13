import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:notes_app/model/modal.dart';

class ApiService {
  static const String url = "https://minenotes-app.herokuapp.com/notes";

  static Future<void> addNote(NoteModel note) async {
    try {
      Uri requestUri = Uri.parse("$url/add");
      var res = await http.post(requestUri, body: note.toMap());
      var decoded = jsonDecode(res.body);
      print(decoded.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> updateNote(NoteModel note) async {
    try {
      Uri requestUri = Uri.parse("$url/add");
      var res = await http.post(requestUri, body: note.toMap());
      var decoded = jsonDecode(res.body);
      print(decoded.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> deleteNote(NoteModel note) async {
    try {
      Uri requestUri = Uri.parse("$url/delete");
      var res = await http.post(requestUri, body: note.id);
      var decoded = jsonDecode(res.body);
      print(decoded.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<List<NoteModel>> getNotes(Map<String, String> userid) async {
    try {
      Uri requestUri = Uri.parse("$url/all/user");
      var res = await http.post(requestUri, body: userid);
      var decoded = jsonDecode(res.body);
      List<NoteModel> list = [];
      for (var note in decoded) {
        list.add(NoteModel.fromMap(note));
      }
      return list;
      //print(decoded.toString());
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}

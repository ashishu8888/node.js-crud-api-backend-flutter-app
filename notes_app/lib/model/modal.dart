import 'dart:convert';
import 'dart:ffi';

import 'package:intl/intl.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoteModel {
  String? id;
  String? userid;
  String? title;
  String? content;
  String? dateadded;
  NoteModel({
    required this.id,
    required this.userid,
    required this.title,
    required this.content,
    this.dateadded,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userid': userid,
      'title': title,
      'content': content,
      'dateadded': dateadded,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] != null ? map['id'] as String : null,
      userid: map['userid'] != null ? map['userid'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      dateadded: map['dateadded'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

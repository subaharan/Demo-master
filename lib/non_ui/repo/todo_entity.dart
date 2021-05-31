import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
 final DateTime completed_at;
  final String id;
  final String title;
  final String description;

  const TodoEntity(this.description, this.id, this.title, this.completed_at);

  Map<String, Object> toJson() {
    return {
      "completed_at": completed_at,
      "description": description,
      "title": title,
      "id": id,
    };
  }

  @override
  List<Object> get props => [completed_at, id, title, description];

  @override
  String toString() {
    return 'TodoEntity { completed_at: $completed_at, description: $description, title: $title, id: $id }';
  }

  static TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity(
      json["description"] as String,
      json["id"] as String,
      json["title"] as String,
      json["completed_at"] as DateTime,
    );
  }
 static DateTime parseTime(dynamic date) {
   return Platform.isIOS ? (date as Timestamp).toDate() : (date as DateTime);
 }
  static TodoEntity fromSnapshot(DocumentSnapshot snap) {
    print("dxdd ${snap.data()}");
    return TodoEntity(

      snap['description'],
      snap.id,
      snap['title'],
        snap['completed_at']==null?null:DateTime.parse(snap['completed_at'].toDate().toString()),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "completed_at": completed_at,
      "description": description,
      "title": title,
    };
  }
}
import 'package:flutter/material.dart';

import '../repo/todo_entity.dart';

@immutable
class Todo {
  DateTime completed_at;
  // final bool complete;
  final String id;
  final String title;
  final String description;

  Todo(this.title, {this.completed_at = null, String note = '', String id})
      : this.description = note ?? '',
        this.id = id;

  Todo copyWith({DateTime complete, String id, String note, String task}) {
    return Todo(
      task ?? this.title,
      completed_at: complete ?? this.completed_at,
      id: id ?? this.id,
      note: note ?? this.description,
    );
  }

  @override
  int get hashCode =>
      completed_at.hashCode ^ description.hashCode ^ title.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Todo &&
              runtimeType == other.runtimeType &&
              completed_at == other.completed_at &&
              title == other.title &&
              description == other.description &&
              id == other.id;

  @override
  String toString() {
    return 'Todo { completed_at: $completed_at, description: $description, title: $title, id: $id }';
  }



  TodoEntity toEntity() {
    return TodoEntity(description, id, title, completed_at);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      entity.title,
      completed_at: entity.completed_at ?? null,
      note: entity.description,
      id: entity.id,
    );
  }
}
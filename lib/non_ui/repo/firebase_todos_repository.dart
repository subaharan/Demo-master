import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/todo.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/todo_entity.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';

import 'package:morphosis_flutter_demo/non_ui/repo/todos_repository.dart';



class FirebaseTodosRepository implements TodosRepository {
  final todoCollection = FirebaseFirestore.instance.collection('tasks_new');

  @override
  Future<void> addNewTodo(Todo todo) {
    return todoCollection.add(todo.toEntity().toDocument());
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    return todoCollection.doc(todo.id).delete();
  }

  @override
  Stream<List<Todo>> todos() {
    return todoCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Todo.fromEntity(TodoEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateTodo(Todo update) {
    return todoCollection
        .doc(update.id).update(update.toEntity().toDocument());
  }

  @override
  Stream<List<Todo>> comptedTodos() {
    return todoCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Todo.fromEntity(TodoEntity.fromSnapshot(doc))).where((element) => element.completed_at != null)
          .toList();
    });
  }
}

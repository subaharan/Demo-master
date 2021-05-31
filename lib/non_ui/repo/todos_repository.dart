import 'dart:async';

import 'package:morphosis_flutter_demo/non_ui/modal/todo.dart';

abstract class TodosRepository {
  Future<void> addNewTodo(Todo todo);

  Future<void> deleteTodo(Todo todo);

  Stream<List<Todo>> todos();

  Stream<List<Todo>> comptedTodos();

  Future<void> updateTodo(Todo todo);
}

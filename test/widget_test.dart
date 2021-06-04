// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/todo.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/todo_entity.dart';

void main() {

  testWidgets('ListView.builder', (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext _, int __) {
            return ListTile(
              title: Text("title"),
              subtitle: Text("description"),
            );
          },
        ),
      ),

    );
    final RenderViewport renderObject = tester.allRenderObjects.whereType<RenderViewport>().first;
    expect(renderObject.clipBehavior, equals(Clip.antiAlias));
  });


 /* Future<List<Todo>> getTodos(Client client) async {
    final response = await client.get('https://jsonplaceholder.typicode.com/todos');

      final List<Todo> updatedTodos = currentState.todos
          .map((todo) => todo).where((element) => element.completed_at != null)
          .toList();
      return all.todos;

  }*/

}

class MockServices {
  @override
  static Future<List<Todo>> getTodos() async {
    return [
      Todo.fromEntity(TodoEntity('Description', 'id', 'title', DateTime.now())),
      Todo.fromEntity(TodoEntity('Description1', 'id1', 'title1', DateTime.now())),
      Todo.fromEntity(TodoEntity('Description2', 'id2', 'title2', DateTime.now())),
      Todo.fromEntity(TodoEntity('Description3', 'id3', 'title3', DateTime.now())),
      Todo.fromEntity(TodoEntity('Description4', 'id4', 'title4', DateTime.now())),
      Todo.fromEntity(TodoEntity('Description5', 'id5', 'title5', DateTime.now())),
      Todo.fromEntity(TodoEntity('Description6', 'id6', 'title6', DateTime.now()))
    ];
  }
}
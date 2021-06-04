import 'package:morphosis_flutter_demo/non_ui/modal/todo.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/todo_entity.dart';
import 'package:test/test.dart';


void main() {
  group('Testing Data Add and remove', () {
List<Todo> list= new List();

    test('A new item should be added', () {
      var dataItem = Todo.fromEntity(TodoEntity('Description', 'id','title', DateTime.now()));
      // Add the number to the list.
      list.add(dataItem);

      // Verify if the number was inserted.
      expect(list.contains(dataItem), true);
    });

    test('An item should be removed', () {
      var dataItem = Todo.fromEntity(TodoEntity('Description', 'id','title', DateTime.now()));
      // Add the number to the list.
      list.add(dataItem);

      // Verify if the number was inserted.
      expect(list.contains(dataItem), true);

      // Remove the number from the list.
      list.remove(dataItem);

      // Verify if the number was removed successfully.
      expect(list.contains(dataItem), false);
    });
  });
}
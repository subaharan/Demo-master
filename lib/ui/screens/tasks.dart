import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphosis_flutter_demo/bloc/todo/todo_bloc.dart';
import 'package:morphosis_flutter_demo/bloc/todo/todo_event.dart';
import 'package:morphosis_flutter_demo/bloc/todo/todo_state.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/todo.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_todos_repository.dart';
import 'package:morphosis_flutter_demo/ui/screens/task.dart';
import 'package:morphosis_flutter_demo/ui/widgets/loader_widet.dart';
import 'package:morphosis_flutter_demo/ui/widgets/nodata_widget.dart';

class TasksPage extends StatefulWidget {
  TasksPage({@required this.title});

  final String title;
  // final List<Task> tasks;

  @override
  _TasksPageStatefull createState() => _TasksPageStatefull();
}

TodoBloc _todoBloc;

class _TasksPageStatefull extends State<TasksPage> {
  @override
  void initState() {
    _todoBloc = BlocProvider.of<TodoBloc>(context);
    // TODO: implement initState
    super.initState();
    if (widget.title == 'Completed Tasks') {
      print("comp --");
      _todoBloc.add(ClearCompleted());
    } else {
      print("Not comp --");
      _todoBloc.add(ToggleAll());
    }
  }

  void addTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) {
                  return TodoBloc(
                    todosRepository: FirebaseTodosRepository(),
                  );
                },
                child: TaskPage(),
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => addTask(context),
          )
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        cubit: _todoBloc,
        builder: (context, state) {
          if (state is TodosLoading) {
            return Center(child: LoaderWidget());
          }
          if (state is TodosNotLoaded) {
            return Center(child: NoDataWidget());
          }
          if (state is TodosLoaded) {
            List<Todo> temp;
            if (widget.title == 'Completed Tasks') {
              temp = state.todos
                  .where((element) => element.completed_at != null)
                  .toList();
            } else {
              temp = state.todos.toList();
            }
            if (temp.length > 0) {
              return ListView.builder(
                itemCount: temp.length,
                itemBuilder: (context, index) {
                  return _Task(
                    temp[index],
                  );
                },
              );
            } else {
              return Center(child: NoDataWidget());
            }
          }

          return new Container(child: const Text(''));
        },
      ),
    );
  }
}

class _Task extends StatelessWidget {
  _Task(this.task);

  final Todo task;

  void _delete() {
    _todoBloc.add(DeleteTodo(task));
  }

  void _toggleComplete() {
    //TODO implement toggle complete to firestore
  }

  void _view(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) {
                  return TodoBloc(
                    todosRepository: FirebaseTodosRepository(),
                  );
                },
                child: TaskPage(task: task),
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          task.completed_at != null
              ? Icons.check_box
              : Icons.check_box_outline_blank,
        ),
        onPressed: _toggleComplete,
      ),
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
        ),
        onPressed: _delete,
      ),
      onTap: () => _view(context),
    );
  }
}

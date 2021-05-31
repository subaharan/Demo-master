import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/bloc/demo/demo_bloc.dart';
import 'package:morphosis_flutter_demo/bloc/todo/todo_bloc.dart';
import 'package:morphosis_flutter_demo/bloc/todo/todo_event.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_todos_repository.dart';
import 'package:morphosis_flutter_demo/ui/screens/home.dart';
import 'package:morphosis_flutter_demo/ui/screens/tasks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      BlocProvider(
        create: (context) => DemoBloc(),
        child: HomePage(),
      ),

      BlocProvider<TodoBloc>(
        create: (context) {
          return TodoBloc(
            todosRepository: FirebaseTodosRepository(),
          )..add(LoadTodos());
        },
        child: TasksPage(
          title: 'All Tasks',
        ),
      ),
      BlocProvider<TodoBloc>(
        create: (context) {
          return TodoBloc(
            todosRepository: FirebaseTodosRepository(),
          )..add(LoadTodos());
        },
        child: TasksPage(
          title: 'Completed Tasks',
        ),
      )

    ];

    return Scaffold(
      body: children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Completed Tasks',
          ),
        ],
      ),
    );
  }
}

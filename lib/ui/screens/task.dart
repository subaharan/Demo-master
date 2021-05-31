import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphosis_flutter_demo/bloc/todo/todo_bloc.dart';
import 'package:morphosis_flutter_demo/bloc/todo/todo_event.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/task.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/todo.dart';
import 'package:morphosis_flutter_demo/non_ui/repo/firebase_manager.dart';

class TaskPage extends StatelessWidget {
  TaskPage({this.task});

  final Todo task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'New Task' : 'Edit Task'),
      ),
      body: _TaskForm(task),
    );
  }
}

class _TaskForm extends StatefulWidget {
  _TaskForm(this.task);

  final Todo task;
  @override
  __TaskFormState createState() => __TaskFormState(task);
}

class __TaskFormState extends State<_TaskForm> {
  static const double _padding = 16;

  __TaskFormState(this.task);


  TodoBloc _todoBloc;

  Todo task;
  TextEditingController _titleController;
  TextEditingController _descriptionController;

  void init() {
    _todoBloc = BlocProvider.of<TodoBloc>(context);
    if (task == null) {
      // task = Todo();
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    } else {
      _titleController = TextEditingController(text: task.title);
      _descriptionController = TextEditingController(text: task.description);
    }
  }

  @override
  void initState() {
    init();
    super.initState();

  }

  void _save(BuildContext context) {
    //TODO implement save to firestore

    if(task==null) {
      _todoBloc.add(AddTodo(
          Todo(_titleController.text, note: _descriptionController.text)));
    }else{

      _todoBloc.add(UpdateTodo(task.copyWith(id: task.id, note: _descriptionController.text, task: _titleController.text, complete: task.completed_at)));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(height: _padding),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              minLines: 5,
              maxLines: 10,
            ),
            SizedBox(height: _padding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Completed ?'),
                CupertinoSwitch(
                  value: task!=null?task.completed_at==null?false:true:false,
                  onChanged: (_) {
                    setState(() {
                      task.completed_at= DateTime.now();
                    });
                  },
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () => _save(context),
              child: Container(
                width: double.infinity,
                child: Center(child: Text(task == null ? 'Create' : 'Update')),
              ),
            )
          ],
        ),
      ),
    );
  }
}

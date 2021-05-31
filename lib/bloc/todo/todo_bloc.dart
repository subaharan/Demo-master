
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphosis_flutter_demo/non_ui/modal/todo.dart';

import 'package:morphosis_flutter_demo/non_ui/repo/todos_repository.dart';
import 'todo_event.dart';
import 'package:rxdart/rxdart.dart';
import 'todo_state.dart';


class TodoBloc extends Bloc<TodoEvent, TodoState> {

  final TodosRepository _todosRepository;
  StreamSubscription _todosSubscription;

  TodoBloc({TodosRepository todosRepository})
      : assert(todosRepository != null),
        _todosRepository = todosRepository,
        super(TodosLoading());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    }else if(event is LoadCompletedTodos){
      yield* _mapLoadCompletedTodosToState();
    }else if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } else if (event is TodosUpdated) {
      yield* _mapTodosUpdateToState(event);
    }
  }

  Stream<TodoState> _mapLoadTodosToState() async* {
    _todosSubscription?.cancel();
    _todosSubscription = _todosRepository.todos().listen(
          (todos) => add(TodosUpdated(todos)),
    );
  }

  Stream<TodoState> _mapLoadCompletedTodosToState() async* {
    _todosSubscription?.cancel();
    _todosSubscription = _todosRepository.comptedTodos().listen(
          (todos) => add(TodosUpdated(todos)),
    );
  }

  Stream<TodoState> _mapAddTodoToState(AddTodo event) async* {
    _todosRepository.addNewTodo(event.todo);
  }

  Stream<TodoState> _mapUpdateTodoToState(UpdateTodo event) async* {
    _todosRepository.updateTodo(event.updatedTodo);
  }

  Stream<TodoState> _mapDeleteTodoToState(DeleteTodo event) async* {
    _todosRepository.deleteTodo(event.todo);
  }

  Stream<TodoState> _mapToggleAllToState() async* {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final allComplete = currentState.todos.every((todo) => todo.completed_at != null);
      final List<Todo> updatedTodos = currentState.todos
          .map((todo) => todo.copyWith(complete: allComplete?null:todo.completed_at))
          .toList();
      updatedTodos.forEach((updatedTodo) {
        _todosRepository.updateTodo(updatedTodo);
      });
    }
  }

  Stream<TodoState> _mapClearCompletedToState() async* {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final List<Todo> completedTodos =
      currentState.todos.where((todo) => todo.completed_at != null).toList();

      final List<Todo> updatedTodos = currentState.todos
          .map((todo) => todo).where((element) => element.completed_at != null)
          .toList();
      updatedTodos.forEach((completedTodo) {
        _todosRepository.updateTodo(completedTodo);
      });
    }
  }

  Stream<TodoState> _mapTodosUpdateToState(TodosUpdated event) async* {
    yield TodosLoaded(event.todos);
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}
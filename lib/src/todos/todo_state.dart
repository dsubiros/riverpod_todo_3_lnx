import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_todo_3_lnx/src/todos/todo.dart';

part 'todo_state.freezed.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState({
    @Default([]) List<Todo> items,
    Todo? selectedTodo,
    @Default(false) isLoading,
  }) = _TodoState;
}

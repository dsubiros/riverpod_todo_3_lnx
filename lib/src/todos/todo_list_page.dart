import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo_3_lnx/src/todos/todo_provider.dart';

class TodoListPage extends HookConsumerWidget {
  const TodoListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoState = ref.watch(todoNotifierProvider);
    final todoNotifier = ref.watch(todoNotifierProvider.notifier);
    final newTodoController = useTextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            const HeaderTile(),
            // TextField
            SizedBox(
              height: 70,
              child: TextField(
                controller: newTodoController,
                enabled: !todoState.isLoading,
                decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: 'What needs to be done?',
                    helper:
                        todoState.isLoading ? const TextFieldHelper() : null),
                onSubmitted: (value) {
                  todoNotifier.add(value);
                  newTodoController.clear();
                },
              ),
            ),
            const Gap(10),
            // TODO: Toolbar
            // TODO: Filtered Todo List
            ...todoState.items.map((todo) => Dismissible(
                  // key: ValueKey(todo.id),
                  key: UniqueKey(),
                  onDismissed: (direction) => todoNotifier.remove(todo),
                  child: ListTile(
                    key: ValueKey(todo.id),
                    title: Text(todo.description),
                  ),
                )),
            // TODO: Todo List, for testing purposes
            ...todoState.items.map(
              (todo) => Text(' - ${todo.toString()}'),
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldHelper extends StatelessWidget {
  const TextFieldHelper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
            height: 10,
            width: 10,
            child: CircularProgressIndicator(strokeWidth: 2)),
        Gap(10),
        Text('Submitting, please wait...')
      ],
    );
  }
}

class HeaderTile extends StatelessWidget {
  const HeaderTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'todos',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.blue, fontSize: 100, fontWeight: FontWeight.w100),
    );
  }
}

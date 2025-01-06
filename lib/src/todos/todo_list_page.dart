import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo_3_lnx/src/todos/todo.dart';
import 'package:riverpod_todo_3_lnx/src/todos/todo_provider.dart';

// @riverpod
// Todo _currentTodo(Ref ref) => throw UnimplementedError();

// final _currentTodo = Prov
final _currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

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
            ...todoState.items.map(
              (todo) => Dismissible(
                // key: ValueKey(todo.id),
                key: UniqueKey(),
                onDismissed: (direction) => todoNotifier.remove(todo),
                child: ProviderScope(
                    overrides: [_currentTodo.overrideWithValue(todo)],
                    child: const TodoItem()),
                // child: ListTile(
                //   key: ValueKey(todo.id),
                //   title: Text(todo.description),
              ),
            ),
            // TODO: Todo List, for testing purposes
            Gap(40),
            ...todoState.items.map((todo) => Text(' - ${todo.toString()}'))
          ],
        ),
      ),
    );
  }
}

class TodoItem extends HookConsumerWidget {
  const TodoItem({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(_currentTodo);
    final notifier = ref.watch(todoNotifierProvider.notifier);

    final itemFocusNode = useFocusNode();
    final itemIsFocused = useIsFocused(itemFocusNode);

    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Material(
        color: Colors.white,
        elevation: 6,
        child: Focus(
          focusNode: itemFocusNode,
          onFocusChange: (focus) {
            if (focus) {
              textEditingController.text = item.description;
            } else {
              /// For performance, commit changes only when the textfield is unfocused
              notifier.edit(
                  id: item.id, description: textEditingController.text);
            }
          },
          child: ListTile(
            onTap: () {
              itemFocusNode.requestFocus();
              textFieldFocusNode.requestFocus();
            },
            leading: Checkbox(
                value: item.isCompleted,
                onChanged: (_) => notifier.toggle(item.id)),
            key: ValueKey(item.id),
            title: (itemIsFocused)
                ? TextField(
                    autofocus: true,
                    controller: textEditingController,
                    focusNode: textFieldFocusNode,
                  )
                : Text(item.description),
          ),
        ));
  }

  bool useIsFocused(FocusNode node) {
    final isFocused = useState(node.hasFocus);

    useEffect(() {
      void listener() {
        isFocused.value = node.hasFocus;
      }

      node.addListener(listener);
      return () => node.removeListener(listener);
    }, [isFocused]);

    return isFocused.value;
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

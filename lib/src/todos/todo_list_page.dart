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
    final isLoading =
        ref.watch(todoListNotifierProvider.select((i) => i.isLoading));
    final filteredItems = ref.watch(filteredTodoList);
    final todoNotifier = ref.watch(todoListNotifierProvider.notifier);
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
                enabled: !isLoading,
                decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: 'What needs to be done?',
                    helper: isLoading ? const TextFieldHelper() : null),
                onSubmitted: (value) {
                  todoNotifier.add(value);
                  newTodoController.clear();
                },
              ),
            ),
            const Gap(10),
            // Toolbar
            const Toolbar(),
            const Gap(20),
            // Filtered Todo List
            ...filteredItems.map(
              (todo) => Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) => todoNotifier.remove(todo),
                child: ProviderScope(
                    overrides: [_currentTodo.overrideWithValue(todo)],
                    child: const TodoItem()),
              ),
            ),
            // Show text Todo List, for testing purposes
            const Gap(40),
            ...ref
                .watch(todoListNotifierProvider)
                .items
                .map((todo) => Text(' - ${todo.toString()}'))
          ],
        ),
      ),
    );
  }
}

class Toolbar extends ConsumerWidget {
  const Toolbar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(incompleteTodosCount);
    final filter = ref.watch(todoListFilter);
    final notifier = ref.watch(todoListFilter.notifier);

    isSelected(TodoListFilter target) => target == filter;

    selectFilter(TodoListFilter target) => notifier.state = target;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text('$count items left')),
        ToolbarItem(
            text: 'ALL',
            message: 'All items',
            isSelected: isSelected(TodoListFilter.all),
            onTap: () => selectFilter(TodoListFilter.all)),
        ToolbarItem(
            text: 'ACTIVE',
            message: 'Active items',
            isSelected: isSelected(TodoListFilter.active),
            onTap: () => selectFilter(TodoListFilter.active)),
        ToolbarItem(
            text: 'COMPLETE',
            message: 'Items already complete',
            isSelected: isSelected(TodoListFilter.complete),
            onTap: () => selectFilter(TodoListFilter.complete)),
      ],
    );
  }
}

class ToolbarItem extends StatelessWidget {
  final String text;
  final String message;
  final bool isSelected;
  final void Function()? onTap;

  const ToolbarItem({
    super.key,
    required this.text,
    required this.message,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: TextButton(
          onPressed: onTap,
          child: Text(text,
              style:
                  TextStyle(color: isSelected ? Colors.blue : Colors.black))),
    );
  }
}

class TodoItem extends HookConsumerWidget {
  const TodoItem({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(_currentTodo);
    final notifier = ref.watch(todoListNotifierProvider.notifier);

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

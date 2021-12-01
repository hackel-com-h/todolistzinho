import 'package:flutter/material.dart';
import 'TodoItem.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todolist :)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(),
    );
  }
}

class Todo {
  String text;
  bool checked;

  Todo({this.text = '', this.checked = false});
  @override
  String toString() => "$text - $checked";
}

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  List<Todo> todos = [];
  String inputText = '';

  void onChangeText(value) => setState(() => inputText = value);

  void removetodo(text) => setState(() {
    todos = todos.where((todo) => todo.text != text).toList();
  });

  void removeAllCompletedTodos() => setState(() {
    todos = [];
  });

  showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Nome da tarefa',
                      hintText: ''
                    ),
                    onChanged: onChangeText,
                  ),
                )
              ]
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text('Salvar Tarefa'),
              onPressed: () {
                var newTodoObj = Todo(text: inputText);

                todos.add(newTodoObj);

                var updatedTodos = todos;

                setState(() {
                  todos = updatedTodos;
                });

                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do Listzinho'),
      ),
      body: Center(
        child: todos.isEmpty ? buildEmpty() : Column(
          children: buildTodoList(),
        ),
      ),
      floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(
                  tooltip: 'Remover Completos',
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.delete_forever),
                  onPressed: removeAllCompletedTodos,
                ),
                FloatingActionButton(
                  tooltip: 'Adicionar',
                  child: const Icon(Icons.add),
                  onPressed: () => showAddTodoDialog(context),
                )
              ],
            ),
          )
    );
  }

  Widget buildEmpty() {
    return const Text('Clique no botão + para adicionar tarefas!');
  }

  List<Widget> buildTodoList() {
    return todos.map((item) => TodoItem(text: item.text, checked: item.checked, removeTodo: removetodo)).toList();
  }
}


import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> _todos = [];
  List<Todo> _editedTodos = [];

  @override
  void initState() {
    super.initState();
    _todos.add(Todo(title: "Comprar leche", description: "Ir al supermercado"));
    _todos
        .add(Todo(title: "Lavar la ropa", description: "Lavar la ropa sucia"));
    _todos.add(Todo(title: "Hacer la cama", description: "Hacer la cama"));
  }

  void _addTodo() {
    var title = TextEditingController();
    var description = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Agregar tarea"),
          content: Column(
            children: [
              TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: "Título",
                ),
              ),
              TextField(
                controller: description,
                decoration: InputDecoration(
                  hintText: "Descripción",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                _applyEdits(); // Aplica las ediciones antes de agregar una nueva tarea
                _todos.add(Todo(
                  title: title.text,
                  description: description.text,
                ));
                Navigator.of(context).pop();
              },
              child: Text("Agregar"),
            ),
          ],
        );
      },
    );
  }

  void _editTodo(Todo todo) {
    var titleController = TextEditingController(text: todo.title);
    var descriptionController = TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Editar tarea"),
          content: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Título",
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: "Descripción",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                todo.title = titleController.text;
                todo.description = descriptionController.text;

                // Agrega la tarea editada a la lista de tareas editadas
                _editedTodos.add(todo);

                Navigator.of(context).pop();
              },
              child: Text("Editar"),
            ),
          ],
        );
      },
    );
  }

  void _applyEdits() {
    // Aplica las ediciones a la lista principal de tareas
    for (var editedTodo in _editedTodos) {
      final index = _todos.indexWhere((todo) => todo.title == editedTodo.title);
      if (index != -1) {
        _todos[index] = editedTodo;
      }
    }

    // Limpia la lista de tareas editadas
    _editedTodos.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tareas"),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          var checkboxListTile = CheckboxListTile(
            value: _todos[index].completed,
            onChanged: (value) {
              setState(() {
                _todos[index].completed = value!;
              });
            },
            title: Text(_todos[index].title),
            subtitle: Text(_todos[index].description),
            secondary: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editTodo(_todos[index]);
              },
            ),
          );
          return checkboxListTile;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _applyEdits(); // Aplica las ediciones antes de agregar una nueva tarea
          _addTodo();
        },
        tooltip: "Agregar tarea",
        child: Icon(Icons.add),
      ),
    );
  }
}

class Todo {
  String title;
  String description;
  bool completed;

  Todo({
    required this.title,
    required this.description,
    this.completed = false,
  });
}

void main() {
  runApp(MaterialApp(
    home: TodoListPage(),
  ));
}

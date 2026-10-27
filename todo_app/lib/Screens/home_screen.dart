import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/Screens/add_todo.dart';
import 'package:todo_app/Screens/update_todo.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loader = true;
  List<dynamic> todos = [];

  Future<void> loadTodos() async {
    setState(() {
      loader = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://todoappnweb.onrender.com/todo'),
      );

      // print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 200) {
        todos = jsonDecode(response.body);
      } else {
        Fluttertoast.showToast(
          msg: "Error: Server error",
          timeInSecForIosWeb: 3,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: Server error", timeInSecForIosWeb: 3);
    }
    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    loadTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodo()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: loader
          ? Center(child: CircularProgressIndicator())
          : todos.isEmpty
          ? Center(child: Text('No data found'))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Icon(Icons.task)),
                    title: Text(todo['title'].toString()),
                    subtitle: Text(todo['description'].toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        todo['completed']
                            ? TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    99,
                                    51,
                                    255,
                                    136,
                                  ),
                                  foregroundColor: Colors.black,
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {},
                                child: Text("Completed"),
                              )
                            : TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    100,
                                    255,
                                    64,
                                    51,
                                  ),
                                  foregroundColor: Colors.black,
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {},
                                child: Text("Pending"),
                              ),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateTodo(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

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

  Future<void> loadTodos() async {
    setState(() {
      loader = true;
    });

    try {
      final response = await http.get(Uri.parse('http://localhost:3000/todo'));

      // print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
      } else {
        Fluttertoast.showToast(msg: "Error: Server error", timeInSecForIosWeb: 3);
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
          : Card(
              child: ListTile(
                title: Text("Todo Title will here"),
                subtitle: Text("Todo Description will here"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(100, 255, 64, 51),
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {},
                      child: Text("Completed"),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UpdateTodo()),
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                  ],
                ),
              ),
            ),
    );
  }
}

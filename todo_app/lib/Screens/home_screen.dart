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


   // update Status function
  Future<void> updateStatus(bool isCompleted, String id) async {
    try {
      if(isCompleted){
        await http.put(
        Uri.parse('https://todoappnweb.onrender.com/todo/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'completed': false,
        }),
      );
      }else{
        await http.put(
        Uri.parse('https://todoappnweb.onrender.com/todo/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'completed': true,
        }),
      );
      }
      Fluttertoast.showToast(
        msg: "Success: Status Update Successfully...",
        timeInSecForIosWeb: 3,
      );
      loadTodos();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: Status Update Failed...",
        timeInSecForIosWeb: 3,
      );
    }
  }

 
 
   // Delete Data function
  Future<void> deleteTodo(String id) async {
    try {
        await http.delete(
        Uri.parse('https://todoappnweb.onrender.com/todo/$id'),
      );
      Fluttertoast.showToast(
        msg: "Success: Todo Delete Successfully...",
        timeInSecForIosWeb: 3,
      );
      loadTodos();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: Todo Delete Failed...",
        timeInSecForIosWeb: 3,
      );
    }
  }


  @override
  void initState() {
    super.initState();
    loadTodos();
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
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Icon(Icons.task)),
                    title: Text(todos[index]['title'].toString()),
                    subtitle: Text(todos[index]['description'].toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        todos[index]['completed']
                            ? TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(99,51,255,136,),
                                  foregroundColor: Colors.black,
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  updateStatus(true ,todos[index]['_id']);
                                },
                                child: Text("Completed"),
                              )
                            : TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(100, 255, 64,51,),
                                  foregroundColor: Colors.black,
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  updateStatus(false ,todos[index]['_id']);
                                },
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
                                    builder: (context) => UpdateTodo(id: todos[index]['_id']),
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteTodo(todos[index]['_id']);
                              },
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

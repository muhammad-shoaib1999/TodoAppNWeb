import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/Screens/home_screen.dart';

class UpdateTodo extends StatefulWidget {
  final String id;
  const UpdateTodo({super.key, required this.id});

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  final title = TextEditingController();
  final desc = TextEditingController();
  bool loader = false;

  // get Data and fill in form function
  Future<void> getSingleData() async {
    setState(() {
      loader = true;
    });
    try {
      final response = await http.get(
        Uri.parse('https://todoappnweb.onrender.com/todo/${widget.id}'),
      );
      if (response.statusCode == 200) {
        dynamic todos = jsonDecode(response.body);
        title.text = todos['title'];
        desc.text = todos['description'];
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
    super.initState();
    getSingleData();
  }

  // update data function
  Future<void> updateTodo() async {
    try {
      await http.put(
        Uri.parse('https://todoappnweb.onrender.com/todo/${widget.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title.text,
          'description': desc.text,
          'completed': false,
        }),
      );
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
      Fluttertoast.showToast(
        msg: "Success: Data Inserted",
        timeInSecForIosWeb: 3,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: Data not inerted",
        timeInSecForIosWeb: 3,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: title,
              decoration: InputDecoration(
                hintText: "Enter title",
                labelText: "Title",
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: desc,
              decoration: InputDecoration(
                hintText: "Enter description",
                labelText: "Description",
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                updateTodo();
              },
              child: Text("Update Todo"),
            ),
          ],
        ),
      ),
    );
  }
}

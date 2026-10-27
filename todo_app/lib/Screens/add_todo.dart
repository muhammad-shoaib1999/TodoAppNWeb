import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final title = TextEditingController();
  final desc = TextEditingController();
  bool loader = false;

  Future<void> AddTodo() async {
    try {
      await http.post(
        Uri.parse('https://todoappnweb.onrender.com/todo'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title.text,
          'description': desc.text,
          'completed': false,
        }),
      );
      setState(() {
        Navigator.pop(context);
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
                AddTodo();
              },
              child: Text("Add Todo"),
            ),
          ],
        ),
      ),
    );
  }
}

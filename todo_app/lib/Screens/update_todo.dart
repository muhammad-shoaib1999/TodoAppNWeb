import 'package:flutter/material.dart';

class UpdateTodo extends StatefulWidget {
  const UpdateTodo({super.key});

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {

  final title = TextEditingController();
  final desc = TextEditingController();
  bool loader = false;

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
                
              },
              child: Text("Update Todo"),
            ),
          ],
        ),
      ),
    );
  }
}
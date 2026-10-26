const express = require('express');
const mongoose = require('mongoose');
var cors = require('cors')
const todo = require('./models/todo.js');

const app = express();

app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

mongoose.connect("mongodb+srv://muhammadshoaib_db_user:shoaib123@cluster0.40uq8gt.mongodb.net/todoDB")
    .then(() => {
        console.log(".......Database is connected.......")
    }).catch((err) => {
        console.log(".......Database is not connected.......")
    })

// Fetch All Daata
app.get("/todo", async(req, res) => {
    const todoList = await todo.find();
    res.json(todoList)
})

// Fetch Single Daata
app.get("/todo/:id", async(req, res) => {
    const todoData = await todo.findById(req.params.id);
    res.json(todoData)
})


// Insert
app.post("/todo", async(req, res) => {
    const todoData = await todo.create(req.body);
    res.send("Inserted")
})

// Update
app.put("/todo/:id", async(req, res) => {
    const todoData = await todo.findByIdAndUpdate(req.params.id, req.body);
    res.send("Updated")
})

// Delete
app.delete("/todo/:id", async(req, res) => {
    const todoData = await todo.findByIdAndDelete(req.params.id);
    res.send("Deleted")
})



app.listen(3000)
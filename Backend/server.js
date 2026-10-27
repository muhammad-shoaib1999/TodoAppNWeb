const express = require('express');
const mongoose = require('mongoose');
var cors = require('cors')
const { Server } = require('socket.io');
const todo = require('./models/todo.js');


const app = express();

// Create HTTP server for Express and Socket.IO.
const server = http.createServer(app);

// Initialize Socket.IO.
const io = new Server(server, {
    cors: {
        origin: '*', // Development only; restrict in production.
        methods: ['GET', 'POST', 'PUT', 'DELETE']
    }
});

app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

mongoose.connect("mongodb+srv://muhammadshoaib_db_user:shoaib123@cluster0.40uq8gt.mongodb.net/todoDB")
    .then(() => {
        console.log(".......Database is connected.......")
    }).catch((err) => {
        console.log(".......Database is not connected.......")
    })

// Socket.IO connection events.
io.on('connection', (socket) => {
    console.log('Client connected:', socket.id);

    socket.on('disconnect', () => {
        console.log('Client disconnected:', socket.id);
    });
});


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
    // Notify every connected client after saving.
        io.emit('todos:changed', {
            action: 'insert',
            id: todoData._id.toString()
        });
    res.send("Inserted")
})

// Update
app.put("/todo/:id", async(req, res) => {
    const todoData = await todo.findByIdAndUpdate(req.params.id, req.body);
        // Notify every connected client after updating.
        io.emit('todos:changed', {
            action: 'update',
            id: todoData._id.toString()
        });

    res.send("Updated")
})

// Delete
app.delete("/todo/:id", async(req, res) => {
    const todoData = await todo.findByIdAndDelete(req.params.id);
     // Notify every connected client after deleting.
        io.emit('todos:changed', {
            action: 'delete',
            id: todoData._id.toString()
        });
    res.send("Deleted")
})



app.listen(3000)
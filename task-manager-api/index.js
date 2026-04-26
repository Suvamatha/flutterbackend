const express = require('express')
const app = express();
const cors = require('cors');

app.use(cors());
app.use(express.json());


app.get('/',(req,res)=>{
    res.send("Task manager is running..");
});

let tasks = [
    {id:1, title: "Buy gloceries", done: false},
    {id:2, title: "Learn Flutter", done: false},
];

app.get('/tasks',(req,res)=>{
    res.json(tasks);
});
//for Post
app.post('/tasks',(req,res)=>{
    const {title} = req.body;

    if(!title){
        return res.status(400).json({message: "Title is requred"});
    }

    const newTask = {
        id: tasks.length + 1,
        title: title,
        done: false,
    };

    tasks.push(newTask);
    res.status(201).json(newTask);
})

//for DELETE
app.delete('/tasks/:id',(req,res)=>{
    const id = parseInt(req.params.id);
    tasks = tasks.filter(task => tasks.id !== id);
    res.json({message: "Task deleted"});
});

app.patch('/tasks/:id', (req,res)=>{
    const id =parseInt(req.params.id);
    const task = tasks.find(task => task.id == id);

    if(!task){
        return res.status(404).json({message: "Task not found"});
    }
    task.done = !task.done;
    res.json(task);
});

app.listen(3000,()=>{
    console.log("Server is running in port 3000");
});
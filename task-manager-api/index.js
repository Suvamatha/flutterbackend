const express = require('express')
const app = express();
const cors = require('cors');
const mongooes = require('mongoose');
require('dotenv').config();

app.use(cors());
app.use(express.json());

mongooes.connect(process.env.MONGO_URI)
.then(() => console.log("MongoDb is connected"))
.catch((err) => console.log("DB Error: ", err))

app.get('/',(req,res)=>{
    res.send("Task manager is running..");
});

let taskSchema = new mongooes.Schema({
    title: String,
    done: {type: Boolean, default: false},
});

const Task = mongooes.model('Task',taskSchema);

app.get('/tasks',async (req,res)=>{
    const tasks = await Task.find();
    res.json(tasks);
});
//for Post
app.post('/tasks', async (req,res)=>{
    const {title} =req.body;

    if(!title){
        return res.status(400).json({message: "Title is required"});
    }
    const newTask = await Task.create({title});
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

app.listen(process.env.PORT,()=>{
    console.log(`Server is running in port ${process.env.PORT}`);
});
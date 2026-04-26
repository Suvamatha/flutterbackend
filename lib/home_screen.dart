// import 'login_screen.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';

class HomeScreen extends StatefulWidget {
  
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController taskcontroller = TextEditingController();
     List<Map<String,dynamic>> tasks = [
        {"title":"Buy groceries","done":false},
        {"title":"Complete Flutter app","done":false},
        {"title":"Read 20 pages","done":false},
        {"title":"Go for a walk","done":false},
    ];

    void handleLogic()async{
      String task = taskcontroller.text;

      if (task.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please Enter the Tasks"),)
        );
        return;
      }
      await ApiService.createTask(task);
      await loadTasks();
      setState(() {
        tasks.add({"title":task,"done":false});
      });
      taskcontroller.clear();

      Navigator.pop(
        context
      );
    }
    @override
  void dispose(){
    taskcontroller.dispose();
    super.dispose();
  }
  @override
  void initState(){
    super.initState();
    loadTasks();
  }
  Future<void> loadTasks()async{
    try{
    final data = await ApiService.getTasks();
    print(data);
    setState(() {
      tasks = List<Map<String,dynamic>>.from(data);
    });
  }catch(e){
    print("Error: $e");
  }}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Task Manager", style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Welcome You are login"),
            Expanded(
            child: ListView.builder(
              
              itemCount: tasks.length,
              itemBuilder: (context,index){
                final task = tasks[index];
                return Dismissible(
                  key: Key(index.toString()),
                  onDismissed: (direction){
                    setState(() {
                      tasks.removeAt(index);
                    });
                  },
                child: ListTile(
                  leading: Icon(
                    task["done"] == true
                    ? Icons.check_box
                    : Icons.check_box_outline_blank
                  ),
                  title: Text(task["title"]),
                  onTap: () {
                    setState(() {
                      tasks[index]["done"]= !tasks[index]["done"];
                    });
                  },
                ),
                );
              },
            )
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            showModalBottomSheet(
              context: context,
              builder: (context){
                return Container(
                  padding: EdgeInsets.all(19),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: taskcontroller,
                        style: TextStyle(color: Colors.amber),
                        decoration: InputDecoration(
                          hintText: "Enter the Task",
                          border: OutlineInputBorder(),

                        ),
                      ),
                      ElevatedButton(
                        onPressed: (){
                           handleLogic();
                        },
                        child: Text("Add Task"),
                      )
                    ],
                  ),
                  
                );
              }
            );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
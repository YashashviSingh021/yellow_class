import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/helpers/Utility.dart';
import 'package:todo/helpers/database_helper.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/screens/add_task_screen.dart';

class TodoListScreeen extends StatefulWidget {
  @override
  _TodoListScreeenState createState() => _TodoListScreeenState();
}

class _TodoListScreeenState extends State<TodoListScreeen> {
  Future<List<Task>> _taskList;
  final DateFormat _dateFormat = DateFormat('MMM dd,yyyy');

  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }

  _updateTaskList() {
    setState(() {
      _taskList = DatabaseHelper.instance.getTaskList();
    });
  }

  Widget _buildTask(Task task) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                  fontSize: 18,
                  decoration: task.status == 0
                      ? TextDecoration.none
                      : TextDecoration.lineThrough),
            ),
            subtitle: Text('${task.director} -- ${_dateFormat.format(task.date)} ',
                style: TextStyle(
                    fontSize: 15,
                    decoration: task.status == 0
                        ? TextDecoration.none
                        : TextDecoration.lineThrough)),
                        trailing: Container(height: 50,width: 50,child: ClipRRect(borderRadius: BorderRadius.circular(5),child: Utility.imageFromBase64String(task.photo),)),
                        // trailing: CircleAvatar(radius: 23,child: CircleAvatar(radius: 60,child: Utility.imageFromBase64String(task.photo),),),
            // trailing: Checkbox(
            //     onChanged: (value) {
            //       task.status = value ? 1 : 0;
            //       DatabaseHelper.instance.updateTask(task);
            //       _updateTaskList();
            //       print(value);
            //     },
            //     activeColor: Theme.of(context).primaryColor,
            //     value: task.status == 1 ? true : false),
            onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (_) => AddTaskSreen(
                          task: task,
                          updateTaskList: _updateTaskList,
                        ))),
          ),
          Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (_) => AddTaskSreen(
                        updateTaskList: _updateTaskList,
                      )));
        },
        child: Icon(Icons.add),
      ),
      body: _taskList==null?Center(child: Text("Add movies"),): FutureBuilder(
        
          future: _taskList,
          builder: (context,AsyncSnapshot snapshot) {
            
            if (!snapshot.hasData) {
              print(snapshot.data);
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final int completedTaskCount = snapshot.data
                .where((Task task) => task.status == 1)
                .toList()
                .length;

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 80),
              itemCount: 1 + snapshot.data.length,
              itemBuilder: (BuildContext context, int i) {
                if (i == 0) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Movies',
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${snapshot.data.length} movies',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  );
                }
                else{}
                return _buildTask(snapshot.data[i - 1]);
              },
            );
          }),
    );
  }
}

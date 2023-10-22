import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_hive/components/dialog_box.dart';
import 'package:to_do_hive/components/todo_tile.dart';
import 'package:to_do_hive/database/hive_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('TODO_DATABASE');

  HiveDataBase db = HiveDataBase();

  final title = TextEditingController();
  final description = TextEditingController();

  @override
  void initState() {
    if (_myBox.get('TODO_LIST') == null) {
      db.createInitdata();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][2] = !db.todoList[index][2];
    });
    db.updateData();
  }

  void saveNewTask() {
    if (title.text.isNotEmpty) {
      setState(() {
        db.todoList.add([
          title.text,
          description.text.isEmpty ? "No Description..." : description.text,
          false
        ]);
      });
    }
    db.updateData();
    title.clear();
    description.clear();
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return ToDoDialogBox(
          titleController: title,
          descriptionController: description,
          title: 'Create New Task...',
          onSave: saveNewTask,
          onCancel: () {
            title.clear();
            description.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void updateExistingTask(int index) {
    title.text = db.todoList[index][0];
    description.text = db.todoList[index][1];
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return ToDoDialogBox(
          titleController: title,
          descriptionController: description,
          title: 'Update New Task...',
          onSave: () {
            setState(() {
              db.todoList[index][0] = title.text;
              db.todoList[index][1] = description.text;
              db.todoList[index][2] = false;
            });
            Navigator.of(context).pop();
            db.updateData();
          },
          onCancel: () {
            title.clear();
            description.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(
            Icons.add,
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
          toolbarHeight: 100,
          centerTitle: true,
          title: const Column(
            children: [
              Text(
                'ToDo',
                style: TextStyle(fontSize: 40),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: db.todoList.length != 0
              ? ListView.builder(
                  itemCount: db.todoList.length,
                  itemBuilder: (context, index) {
                    return TodoTile(
                      taskTitle: db.todoList[index][0],
                      taskDescription: db.todoList[index][1],
                      taskCompleted: db.todoList[index][2],
                      rewriteTask: () => updateExistingTask(index),
                      onChanged: (value) => checkBoxChanged(value, index),
                      deleteFunction: (context) => deleteTask(index),
                    );
                  },
                )
              : Container(
                  height: 120,
                  child: Center(
                    child: Text(
                      "Nothing Here...!",
                      style:
                          TextStyle(fontSize: 25, color: Colors.grey.shade600),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

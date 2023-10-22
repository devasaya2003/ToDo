import 'package:hive_flutter/hive_flutter.dart';

class HiveDataBase {
  List todoList = [];
  final _myBox = Hive.box('TODO_DATABASE');
  void createInitdata() {
    todoList = [
      [
        "Friedrich Nietzsche",
        "He who has a why to live can bear almost any how.",
        false
      ],
      [
        "Albert Einstein",
        "We cannot solve our problems with the same thinking we used when we created them.",
        false
      ],
      [
        "Functions You Can Perform",
        "1. Box at the left to mark done...\n2. Slide left and tap the bin to delete...\n3. (+) button to add a new task...\n4. Tap on a task to edit...\nLet's go!!!",
        false
      ],
    ];
  }

  void loadData() {
    todoList = _myBox.get('TODO_LIST');
  }

  void updateData() {
    _myBox.put('TODO_LIST', todoList);
  }
}

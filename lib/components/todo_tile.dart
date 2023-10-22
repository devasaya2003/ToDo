import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskTitle;
  final String taskDescription;
  final bool taskCompleted;
  final Function()? rewriteTask;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  const TodoTile({
    super.key,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskCompleted,
    this.onChanged,
    this.deleteFunction, this.rewriteTask,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: rewriteTask,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
            color: taskCompleted ? Colors.black12 : Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(20)),
        child: Slidable(
          endActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(20),
              backgroundColor: Colors.redAccent,
              onPressed: deleteFunction,
              icon: Icons.delete,
            )
          ]),
          child: Row(
            children: [
              Checkbox(
                  activeColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  value: taskCompleted,
                  onChanged: onChanged),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskTitle,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      taskDescription,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

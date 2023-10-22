import 'package:flutter/material.dart';

class ToDoDialogBox extends StatelessWidget {
  final titleController;
  final descriptionController;
  final String title;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const ToDoDialogBox(
      {super.key,
      required this.title,
      required this.onSave,
      required this.onCancel,
      required this.titleController,
      required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: AlertDialog(
        title: Text(title),
        backgroundColor: Colors.grey.shade100,
        content: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Title...",
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: descriptionController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Description...",
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DialogButton(
                      text: 'Save!',
                      onPressed: onSave,
                    ),
                    const SizedBox(width: 10),
                    DialogButton(
                      text: 'Cancel!',
                      onPressed: onCancel,
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}

class DialogButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const DialogButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

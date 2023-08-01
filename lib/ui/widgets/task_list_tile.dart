import 'package:flutter/material.dart';
import 'package:todo/data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class TaskListTile extends StatefulWidget {
  const TaskListTile({
    Key? key,
    required this.data,
    required this.onTaskDeleted,
    required this.onTaskStatusChange,
  }) : super(key: key);

  final TaskData data;
  final VoidCallback onTaskDeleted;
  final VoidCallback onTaskStatusChange;

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  @override
  Widget build(BuildContext context) {
    Future<void> deleteTask() async {
      await NetworkCaller()
          .getRequest(Urls.deleteTask + widget.data.sId.toString());
      widget.onTaskDeleted(); // Call the callback function to trigger refresh
    }

    Future<void> changeStatus(String progress) async {
      await NetworkCaller()
          .getRequest('${Urls.updateTaskStatus}${widget.data.sId}/$progress');
      widget
          .onTaskStatusChange(); // Call the callback function to trigger status change
    }

    return ListTile(
      title: Text(widget.data.title ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.data.description ?? ''),
          Text(widget.data.createdDate ?? ''),
          Row(
            children: [
              Chip(
                label: Text(
                  widget.data.status ?? 'New',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blue,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    deleteTask();
                  },
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red.shade300,
                  )),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Change The Progress Of the Task"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                changeStatus('New');
                                Navigator.pop(context);
                              },
                              child: const Text("New"),
                            ),
                            TextButton(
                              onPressed: () {
                                changeStatus('Completed');
                                Navigator.pop(context);
                              },
                              child: const Text("Completed"),
                            ),
                            TextButton(
                              onPressed: () {
                                changeStatus('Progress');
                                Navigator.pop(context);
                              },
                              child: const Text("InProgress"),
                            ),
                            TextButton(
                              onPressed: () {
                                changeStatus('Cancel');
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel The Task"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  )),
            ],
          )
        ],
      ),
    );
  }
}

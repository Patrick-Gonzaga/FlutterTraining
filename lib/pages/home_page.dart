import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/widgets/task_item_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController taskController = TextEditingController();

  List<TaskModel> taskList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: taskController,
                        decoration: InputDecoration(
                          labelText: 'Tarefa',
                          hintText: 'Ex.: Estudar Flutter',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          taskList.add(
                            TaskModel(
                              taskName: taskController.text,
                              dateTime: DateTime.now(),
                              isDone: false,
                            ),
                          );
                        });

                        taskController.clear();
                      },
                      child: Icon(Icons.add, size: 30),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF90EE90),
                        padding: EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Flexible(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  shrinkWrap: true,
                  children: [
                    for (TaskModel task in taskList)
                      TaskItemWidget(task: task, onDelete: delete),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${taskList.length} tarefas pendentes...',
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        deleteAllDialog();
                      },
                      child: Text('Limpar tudo'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Color(0xFF90EE90),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Atenção'),
        content: Text('Você tem certeza que quer REMOVER todas as tarefas?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              deleteAll(taskList);
              Navigator.of(context).pop();
            },
            child: Text('Confirmar'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Color(0xFF90EE90),
            ),
          ),
        ],
      ),
    );
  }

  void deleteAll(List<TaskModel> taskListParam) {
    List<TaskModel> deletedTaskList = [...taskListParam];
    print(deletedTaskList);
    setState(() {
      taskListParam.clear();
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Todas as tarefas foram removidas!'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () => setState(() {
            taskList = [...deletedTaskList];
            print(taskList);
          }),
        ),
        duration: Duration(seconds: 5),
      ),
    );
  }

  void delete(TaskModel task) {
    int posDeletedTask = taskList.indexOf(task);
    setState(() {
      taskList.remove(task);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tarefa "${task.taskName}" removida com sucesso!'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () => setState(() {
            taskList.insert(posDeletedTask, task);
          }),
        ),
        duration: Duration(seconds: 5),
      ),
    );
  }
}

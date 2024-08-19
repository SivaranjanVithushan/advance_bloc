import 'package:advance_bloc/bloc/task_bloc.dart';
import 'package:advance_bloc/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          PopupMenuButton<TaskFilter>(
            onSelected: (filter) {
              context.read<TaskBloc>().add(FilterTasks(filter));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: TaskFilter.all, child: Text('All Tasks')),
              const PopupMenuItem(
                  value: TaskFilter.completed, child: Text('Completed Tasks')),
              const PopupMenuItem(
                  value: TaskFilter.incomplete,
                  child: Text('Incomplete Tasks')),
            ],
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            final tasks = state.filteredTasks;

            if (tasks.isEmpty) {
              return const Center(child: Text('No tasks available.'));
            }

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task.description),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) {
                      context
                          .read<TaskBloc>()
                          .add(ToggleTaskCompletion(task.id));
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<TaskBloc>().add(RemoveTask(task.id));
                    },
                  ),
                );
              },
            );
          } else if (state is TaskError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newTask = Task(
            id: DateTime.now().toString(),
            description: 'New Task ${DateTime.now()}',
          );
          context.read<TaskBloc>().add(AddTask(newTask));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

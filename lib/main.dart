import 'package:advance_bloc/bloc/task_bloc.dart';
import 'package:advance_bloc/repository/task_repository.dart';
import 'package:advance_bloc/task_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      home: BlocProvider(
        create: (context) => TaskBloc(taskRepository: TaskRepository()),
        child: const TaskPage(),
      ),
    );
  }
}

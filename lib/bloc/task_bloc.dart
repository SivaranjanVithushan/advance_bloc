import 'dart:developer';

import 'package:advance_bloc/models/task_model.dart';
import 'package:advance_bloc/repository/task_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc({required this.taskRepository})
      : super(const TaskLoaded(tasks: [], filter: TaskFilter.all)) {
    on<AddTask>(_addTask);
    on<RemoveTask>(_removeTask);
    on<ToggleTaskCompletion>(_toggleTaskCompletion);
    on<FilterTasks>(_filterTasks);
  }

  @override
  void onChange(Change<TaskState> change) {
    log('Bloc - $change');
    super.onChange(change);
  }

  void _addTask(event, emit) async {
    emit(TaskLoading());
    try {
      taskRepository.addTask(event.task);
      emit(TaskLoaded(tasks: taskRepository.getTasks()));
    } catch (e) {
      emit(const TaskError('Failed to add task'));
    }
  }

  void _removeTask(event, emit) async {
    emit(TaskLoading());
    try {
      taskRepository.removeTask(event.id);
      emit(TaskLoaded(tasks: taskRepository.getTasks()));
    } catch (e) {
      emit(const TaskError('Failed to remove task'));
    }
  }

  void _toggleTaskCompletion(event, emit) async {
    emit(TaskLoading());
    try {
      taskRepository.toggleTaskCompletion(event.id);
      emit(TaskLoaded(tasks: taskRepository.getTasks()));
    } catch (e) {
      emit(const TaskError('Failed to toggle task completion'));
    }
  }

  void _filterTasks(event, emit) {
    emit(TaskLoaded(tasks: taskRepository.getTasks(), filter: event.filter));
  }
}

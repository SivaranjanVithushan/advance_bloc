part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class AddTask extends TaskEvent {
  final Task task;

  const AddTask(this.task);

  @override
  List<Object> get props => [task];
}

class RemoveTask extends TaskEvent {
  final String id;

  const RemoveTask(this.id);

  @override
  List<Object> get props => [id];
}

class ToggleTaskCompletion extends TaskEvent {
  final String id;

  const ToggleTaskCompletion(this.id);

  @override
  List<Object> get props => [id];
}

class FilterTasks extends TaskEvent {
  final TaskFilter filter;

  const FilterTasks(this.filter);

  @override
  List<Object> get props => [filter];
}

enum TaskFilter { all, completed, incomplete }

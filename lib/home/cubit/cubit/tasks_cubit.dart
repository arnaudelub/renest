import 'package:backend/backend.dart';
import 'package:bloc/bloc.dart';

class TasksCubit extends Cubit<List<Map<String, String>>?> {
  TasksCubit(this.storage) : super([]);

  final Storage storage;

  Future<void> getPrioritizedTasks() async {
    final tasks = await storage.getPrioritizedTasks();
    emit(tasks);
  }

  Future<void> getCompletedTasks() async {
    final tasks = await storage.getCompletedTasks();
    emit(tasks);
  }

  Future<void> getAvailableTasks() async {
    final tasks = await storage.getAvailableTasks();
    emit(tasks);
  }

  Future<void> addTask(String task, Priority priority) async {
    await storage.addTask(task, priority);
    await getAvailableTasks();
  }

  Future<void> completeTask(String task) async {
    await storage.completeTask(task);
    await getCompletedTasks();
  }
}

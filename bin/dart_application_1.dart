
 import 'dart:io';

class Task{
  int id;
  String taskName;
  bool isCompleted;

  Task(this.id, this.taskName, this.isCompleted);

  @override
  String toString(){
    if(isCompleted){
      return "$id : $taskName - completed";
    }else{
      return "$id : $taskName - uncompleted";
    }
  }
}


class TaskManager {
  List<Task> tasks = [];
  int _nextId = 1;

  void addTask(String taskName){
    tasks.add(Task(_nextId++, taskName, false));
    print('Task -$taskName created');
  }

  void deleteTask(int taskID){
    final taskIndex = tasks.indexWhere((task) => task.id == taskID);
    if(taskIndex != -1){
      tasks.removeAt(taskIndex);
      print("Task with id $taskID has been deleted");
    }else{
      throw TaskNotFoundException('Task with ID $taskID not found');
    }

  }

  void editTask(int taskID, String newTaskName){
    final  taskIndex = tasks.indexWhere((task) => task.id == taskID);
    if(taskIndex != -1){
      final task = tasks.firstWhere((element) => element.id == taskID);
      task.taskName = newTaskName;
      print("Task successfully edited");
    }else{
        throw TaskNotFoundException('Task with ID $taskID not found');
    }

  }

  void completeTask(int taskID){
    final  taskIndex = tasks.indexWhere((task) => task.id == taskID);
    if(taskIndex != -1){
      final task = tasks.firstWhere((element) => element.id == taskID);
      task.isCompleted = true;
      print("Task successfully completed");
    }else{
        throw TaskNotFoundException('Task with ID $taskID not found');
    }

  }


  void listTasks(){
    if(tasks.isEmpty){
      print("No tasks found.");
    }else{
      for(int i=0; i < tasks.length; i++){
        print(tasks[i]);
      }
    
    }
  }
}

class TaskNotFoundException implements Exception{
  final String errorMessage;

  TaskNotFoundException(this.errorMessage);

  @override
  String toString() => errorMessage;

}

void main(){
  final taskManager = TaskManager();

  while(true){
    print('Menu');
    print('1. Add Task');
    print('2. Edit Task');
    print('3. Delete Task');
    print('4. Complete Task');
    print('5. List Tasks');
    print('6. Quit');
    stdout.write('Enter command: ');

    try {
      final choice = int.parse(stdin.readLineSync()!);

      switch (choice) {
        case 1:
          stdout.write('Enter task name: ');
          final taskName = stdin.readLineSync()!;
          taskManager.addTask(taskName);
          break;

        case 2:
          stdout.write('Enter task ID to edit: ');
          final id = int.parse(stdin.readLineSync()!);
          stdout.write("Enter new task name: ");
          final newTaskName = stdin.readLineSync()!;
          taskManager.editTask(id, newTaskName);
          break;
        case 3:
          stdout.write('Enter task ID to delete: ');
          final id = int.parse(stdin.readLineSync()!);
          taskManager.deleteTask(id);
          break;
        case 4:
          stdout.write('Enter task ID to complete: ');
          final id = int.parse(stdin.readLineSync()!);
          taskManager.completeTask(id);
          break;
        case 5:
          taskManager.listTasks();
          break;
        case 6:
          exit(0);
        default:
          print('Invalid choice. Please try again. ');
          break;
      }
    } catch (e) {
      if(e is FormatException){
        print('Invalid input. Please enter a number.');
      }else if (e is TaskNotFoundException){
        print(e.toString());
      }else {
        print('An error occurred: $e');
      }
      
    }
  }

}



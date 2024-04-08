import 'package:logger/logger.dart';

class TaskitModal {
  int? id;
  String? title;
  String? category;
  String? date;
  String? duedate;
  String? duetime;
  String? description;

  bool? status;
  TaskitModal(
      {this.title,
      this.date,
      this.duedate,
      this.duetime,
      this.description,
      this.status});

  TaskitModal.init() {
    Logger().i("init called");
  }

  TaskitModal.fromMap(Map task) {
    id = task['Id'];
    title = task['Title'];
    category = task['Category'];
    date = task['Date'];
    duedate = task['DueDate'];
    duetime = task['DueTime'];
    description = task['Description'];
    status = task['Status'];
  }
}

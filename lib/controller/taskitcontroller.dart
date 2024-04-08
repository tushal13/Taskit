import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskitController extends ChangeNotifier {
  String category = "";
  String date = DateFormat.yMMMd().format(DateTime.now());
  String duadate = DateFormat.yMMMd().format(DateTime.now());
  String duatime = '${TimeOfDay.now().hour % 12}:${TimeOfDay.now().minute}';
  void changeCategory(String newCategory) {
    category = newCategory;
    notifyListeners();
  }

  showMyDate(BuildContext context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2999),
    );

    if (pickDate != null) {
      String formattedDate = DateFormat.yMMMd().format(pickDate);
      date = formattedDate;
    }
    notifyListeners();
  }

  showMydDate(BuildContext context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2999),
    );

    if (pickDate != null) {
      String formattedDate = DateFormat.yMMMd().format(pickDate);
      duadate = formattedDate;
    }
    notifyListeners();
  }

  showMyTime(BuildContext context) async {
    TimeOfDay? pickDate = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickDate != null) {
      duatime = pickDate.format(context);
    }

    notifyListeners();
  }

  DateTime parseDate(String dateString) {
    DateFormat dateFormat = DateFormat("MMM d, yyyy");

    return dateFormat.parse(dateString);
  }

  String convertDateFormat(String dateString) {
    DateTime date = parseDate(dateString);
    DateTime now = DateTime.now();
    Duration duration = now.difference(date).abs(); // Take the absolute value

    if (duration.inDays == 0) {
      // If difference is less than 24 hours, return the difference in hours
      if (duration.inHours > 0) {
        return '${duration.inHours} hours remaining';
      } else {
        // If difference is less than 1 hour, return "Just now"
        return '${duration.inMinutes} minutes remaining';
      }
    } else {
      // If difference is more than 24 hours, return the difference in days
      return '${duration.inDays} days  remaining';
    }
  }
}

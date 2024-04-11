import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskit/controller/taskitcontroller.dart';
import 'package:taskit/controller/theme_controller.dart';
import 'package:taskit/modal/taskitmodal.dart';

import '../../helper/fb_storehelper.dart';

class TaskitTile extends StatelessWidget {
  TaskitModal task;
  TaskitTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeController>(context).isDark;
    String remi = Provider.of<TaskitController>(context)
        .convertDateFormat(task.duedate ?? '');
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        Radio(
            activeColor: isDark ? Colors.white : Colors.black.withOpacity(0.5),
            value: task.status,
            groupValue: true,
            onChanged: (value) async {
              if (task.status = false) {
              } else {
                task.status = true;
                await FbStoreHelper.fbStoreHelper.addCompleted(task: task);
              }
            }),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: task.status == true
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationThickness: 5,
                decorationColor: task.status == true
                    ? isDark
                        ? Colors.white.withOpacity(0.5)
                        : Colors.black.withOpacity(0.5)
                    : isDark
                        ? Colors.white
                        : Colors.black.withOpacity(0.5),
                color: task.status == true
                    ? isDark
                        ? Colors.white.withOpacity(0.5)
                        : Colors.black.withOpacity(0.5)
                    : isDark
                        ? Colors.white
                        : Colors.black,
              ),
            ),
            Text(
              '${task.duedate} ${task.duetime}' ?? "",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        Spacer(),
        Text(
          task.status == true ? 'Completed...' : remi,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ]),
      decoration: BoxDecoration(
          color: isDark ? Colors.black.withOpacity(0.5) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
            )
          ]),
    );
  }
}

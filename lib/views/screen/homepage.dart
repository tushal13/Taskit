import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:taskit/views/component/taskittile.dart';
import 'package:taskit/views/screen/addtask.dart';

import '../../helper/fb_storehelper.dart';
import '../../modal/taskitmodal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            'assets/images/icon.png',
          ),
        ),
        title: Text(
          'Taskit',
          style:
              TextStyle(fontWeight: FontWeight.w600, color: Color(0xff0f1933)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tasks',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FbStoreHelper.fbStoreHelper.fetchTasks(),
                  builder: (context, snapshot) {
                    QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
                    List<QueryDocumentSnapshot<Map<String, dynamic>>> myData =
                        data?.docs ?? [];
                    List<TaskitModal> tasks = myData
                        .map((e) => TaskitModal.fromMap(e.data()))
                        .toList();
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return TaskitTile(task: tasks[index]);
                        });
                  }),
            ),
            Text(
              'Completed Tasks',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FbStoreHelper.fbStoreHelper.fetchCompletedTasks(),
                  builder: (context, snapshot) {
                    QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
                    List<QueryDocumentSnapshot<Map<String, dynamic>>> myData =
                        data?.docs ?? [];
                    List<TaskitModal> tasks = myData
                        .map((e) => TaskitModal.fromMap(e.data()))
                        .toList();
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        itemCount: tasks.length < 5 ? tasks.length : 5,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(children: [
                              Radio(
                                  activeColor: Colors.black.withOpacity(0.5),
                                  value: tasks[index].status,
                                  groupValue: true,
                                  onChanged: (value) {
                                    tasks[index].status = true;
                                    FbStoreHelper.fbStoreHelper
                                        .addCompleted(task: tasks[index]);
                                  }),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    tasks[index].title ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 5,
                                      decorationColor:
                                          Colors.black.withOpacity(0.5),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  Text(
                                    '${tasks[index].duedate} ${tasks[index].duetime}' ??
                                        "",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                'Completed',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ]),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(child: AddTaskPage(), type: PageTransitionType.fade),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

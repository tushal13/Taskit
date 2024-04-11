import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskit/modal/taskitmodal.dart';

import 'fb_authhelper.dart';

class FbStoreHelper {
  FbStoreHelper._();

  static final FbStoreHelper fbStoreHelper = FbStoreHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String usersCollection = 'Users';
  String allusersCollection = 'AllUsers';

  late String currentUser =
      FBAuthHelper.fbAuthHelper.auth.currentUser!.email.toString();

  addUser({required String email}) async {
    await firestore.collection(allusersCollection).doc(email).set({
      'email': email,
    });
  }

  Future<void> addTasks({required TaskitModal task}) async {
    DocumentSnapshot<Map<String, dynamic>> data = await firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('demo')
        .doc('To-do')
        .get();
    Map<String, dynamic> myData = data.data() ?? {};
    int id = myData['id'] ?? 0;

    await firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Tasks')
        .doc(id.toString())
        .set({
      'Id': id,
      'Title': task.title,
      'Category': task.category,
      'Date': task.date,
      'DueDate': task.duedate,
      'DueTime': task.duetime,
      'Description': task.description,
      'Status': task.status,
    });
    await firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('demo')
        .doc('To-do')
        .set({'id': ++id});
  }

  Future<void> addCompleted({
    required TaskitModal task,
  }) async {
    if (task.status == false) {
      print("task is not already completed");
    } else {
      await firestore
          .collection(usersCollection)
          .doc(currentUser)
          .collection('Tasks')
          .doc(task.id.toString())
          .delete();
      await firestore
          .collection(usersCollection)
          .doc(currentUser)
          .collection('Completed Tasks')
          .doc(task.category.toString())
          .set({
        'Id': task.id,
        'Title': task.title,
        'Category': task.category,
        'Date': task.date,
        'DueDate': task.duedate,
        'DueTime': task.duetime,
        'Description': task.description,
        'Status': task.status,
      });
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchTasks() {
    return firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Tasks')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCompletedTasks() {
    return firestore
        .collection(usersCollection)
        .doc(currentUser)
        .collection('Completed Tasks')
        .snapshots();
  }
}

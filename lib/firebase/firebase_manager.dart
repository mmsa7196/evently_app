import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_c13_sun/models/task_model.dart';

class FirebaseManager {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (model, _) {
        return model.toJson();
      },
    );
  }

  static Future<void> addEvent(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getEvents() {
    var collection = getTasksCollection();
    return collection.orderBy("date", descending: false).snapshots();
  }

  static Future<void> deleteTask(String id) {
    var collection = getTasksCollection();

    return collection.doc(id).delete();
  }

  static Future<void> updateTask(TaskModel model) {
    var collection = getTasksCollection();

    return collection.doc(model.id).update(model.toJson());
  }
}

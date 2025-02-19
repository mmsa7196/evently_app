import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_c13_sun/models/task_model.dart';
import 'package:todo_c13_sun/models/user_model.dart';
class FirebaseManager {
  static CollectionReference<EventModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<EventModel>(
      fromFirestore: (snapshot, _) {
        Map<String, dynamic> data = snapshot.data()!;
        return EventModel(
          id: snapshot.id,
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          date: data['date'] ?? 0,
          time: data['time'] ?? false,
          image: data['image'] ?? '',
          category: data['category'] ?? '',
          userId: data['userId'] ?? '',
          isDone: data['isDone'] ?? false,
          latitude: data['latitude'] ?? 0.0,
          longitude: data['longitude'] ?? 0.0,
        );
      },
      toFirestore: (model, _) {
        return {
          'title': model.title,
          'description': model.description,
          'date': model.date,
          'time': model.time,
          'image': model.image,
          'category': model.category,
          'userId': model.userId,
          'isDone': model.isDone,
          'latitude': model.latitude,
          'longitude': model.longitude,
        };
      },
    );
  }


  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (model, _) {
        return model.toJson();
      },
    );
  }

  static Future<void> addEvent(EventModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> addUser(UserModel user) {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  static Stream<QuerySnapshot<EventModel>> getEvents(String categoryName) {
    var collection = getTasksCollection();
    if (categoryName == "All") {
      return collection
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy("date", descending: false)
          .snapshots();
    } else {
      return collection
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where("category", isEqualTo: categoryName)
          .orderBy("date", descending: false)
          .snapshots();
    }
  }

  static Future<UserModel?> readUser() async {
    var collection = getUsersCollection();

    DocumentSnapshot<UserModel> docRef =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return docRef.data();
  }

  static Future<void> deleteTask(String id) {
    var collection = getTasksCollection();

    return collection.doc(id).delete();
  }

  static Future<void> updateTask(EventModel model) {
    var collection = getTasksCollection();

    return collection.doc(model.id).update(model.toJson());
  }

  static Future<void> createAccount(
      String name,
      String emailAddress,
      String password,
      Function onLoading,
      Function onSuccess,
      Function onError) async {
    try {
      onLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      credential.user!.sendEmailVerification();
      UserModel userModel = UserModel(
          id: credential.user!.uid,
          name: name,
          email: emailAddress,
          createdAt: DateTime.now().millisecondsSinceEpoch);
      await addUser(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      onError("Something went wrong");

      print(e);
    }
  }
  static Future<void>deletEvent(String id)async {
    var  reference=getTasksCollection();
   await reference.doc(id).delete();
    }
  static logout() {
    FirebaseAuth.instance.signOut();
  }
  static Future<void>ubdateEvent(EventModel model)async {
    var  reference=getTasksCollection();
    await reference.doc(model.id).update(model.toJson());
  }
}

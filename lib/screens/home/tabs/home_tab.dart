import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_c13_sun/firebase/firebase_manager.dart';
import 'package:todo_c13_sun/models/task_model.dart';

import '../../widgets/event_item.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        leadingWidth: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back ✨",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white, fontSize: 17),
            ),
            Text(
              "John Safwat",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Cairo , Egypt",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.sunny)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: Text(
              "EN",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        )),
        toolbarHeight: 174,
      ),
      body: StreamBuilder<QuerySnapshot<TaskModel>>(
        stream: FirebaseManager.getEvents(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return EventItem(
                    model: snapshot.data!.docs[index].data(),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 4,
                  );
                },
                itemCount: snapshot.data?.docs.length ?? 0),
          );
        },
      ),
    );
  }
}

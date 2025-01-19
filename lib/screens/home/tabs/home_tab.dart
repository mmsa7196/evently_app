import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/firebase/firebase_manager.dart';
import 'package:todo_c13_sun/models/task_model.dart';
import 'package:todo_c13_sun/providers/user_provider.dart';

import '../../widgets/event_item.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedCategory = 0;

  List<String> eventsCategories = [
    "All",
    "birthday",
    "book_club",
    "eating",
    "meeting",
    "exhibtion",
    "holiday",
    "sport",
    "workshop",
  ];

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

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
              userProvider.userModel?.name ?? "null",
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
            SizedBox(
              height: 8,
            ),
            Container(
              height: 40,
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  width: 12,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      selectedCategory = index;
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white),
                          color: selectedCategory == index
                              ? Colors.white
                              : Colors.transparent),
                      child: Text(
                        eventsCategories[index],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: selectedCategory == index
                                ? Theme.of(context).primaryColor
                                : Colors.white),
                      ),
                    ),
                  );
                },
                itemCount: eventsCategories.length,
                scrollDirection: Axis.horizontal,
              ),
            )
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
        stream: FirebaseManager.getEvents(eventsCategories[selectedCategory]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Tasks"));
          }
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

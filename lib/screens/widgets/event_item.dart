import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_c13_sun/firebase/firebase_manager.dart';
import 'package:todo_c13_sun/models/task_model.dart';

class EventItem extends StatelessWidget {
  TaskModel model;

  EventItem({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        height: 230,
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/images/${model.category}.png",
                    fit: BoxFit.fill,
                    height: double.infinity,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        model.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.black),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          FirebaseManager.deleteTask(model.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Icon(
                            Icons.delete,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                      ),
                      Icon(
                        Icons.favorite,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 8, top: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateTime.fromMillisecondsSinceEpoch(model.date)
                        .toString()
                        .substring(8, 10),
                  ),
                  Text(millisecondsToMonth(model.date)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String millisecondsToMonth(int milliseconds) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return DateFormat('MMM').format(date);
  }
}

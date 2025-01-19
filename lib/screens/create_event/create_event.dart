import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/firebase/firebase_manager.dart';
import 'package:todo_c13_sun/models/task_model.dart';
import 'package:todo_c13_sun/providers/create_events_provider.dart';
import 'package:todo_c13_sun/widgets/event_category_item.dart';

class CreateEventScreen extends StatelessWidget {
  static const String routeName = "CreateEvent";

  CreateEventScreen({super.key});

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateEventsProvider(),
      builder: (context, child) {
        var provider = Provider.of<CreateEventsProvider>(context);

        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            title: Text(
              "Create Event",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      "assets/images/${provider.imageName}.png",
                      height: 225,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 44,
                    alignment: Alignment.center,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        width: 16,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            provider.changeEventType(index);
                          },
                          child: EventCategoryItem(
                            eventType: provider.eventsCategories[index],
                            isSelected: provider.eventsCategories[index] ==
                                provider.selectedEvent,
                          ),
                        );
                      },
                      itemCount: provider.eventsCategories.length,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: titleController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: const InputDecoration(
                      hintText: "Title",
                      prefixIcon: Icon(Icons.edit_note),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: descriptionController,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "description",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Date",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      InkWell(
                        onTap: () async {
                          var chosenDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate:
                                  DateTime.now().subtract(Duration(days: 365)),
                              lastDate:
                                  DateTime.now().add(Duration(days: 365)));

                          if (chosenDate != null) {
                            provider.changeSelectedDate(chosenDate);
                          }
                        },
                        child: Text(
                          provider.selectedDate.toString().substring(0, 10),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          TaskModel task = TaskModel(
                              userId: FirebaseAuth.instance.currentUser!.uid,
                              date:
                                  provider.selectedDate.millisecondsSinceEpoch,
                              title: titleController.text,
                              category: provider.imageName,
                              description: descriptionController.text);
                          FirebaseManager.addEvent(task).then(
                            (value) {
                              Navigator.pop(context);
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Color(0xFF5669FF)),
                        child: Text(
                          "Add Event",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

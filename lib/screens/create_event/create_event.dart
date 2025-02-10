import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/firebase/firebase_manager.dart';
import 'package:todo_c13_sun/models/task_model.dart';
import 'package:todo_c13_sun/providers/create_events_provider.dart';
import 'package:todo_c13_sun/screens/create_event/picker_location_screen.dart';
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
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 44,
                    alignment: Alignment.center,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
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
                  const SizedBox(
                    height: 16,
                  ),
                  Row(children: [Text("Title",style: Theme.of(context).textTheme.titleSmall,)],),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: titleController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: const InputDecoration(
                      hintText: "Event Title",
                      prefixIcon: Icon(Icons.edit_note),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(children: [Text("Description",style: Theme.of(context).textTheme.titleSmall,)],),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: descriptionController,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: "Make thoughtful choices to balance your decisions carefully.",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined),
                      const SizedBox(width: 10,),
                      Text(
                        "Select Date",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          var chosenDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate:
                                  DateTime.now().subtract(const Duration(days: 365)),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)));

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
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined),
                      const SizedBox(width: 10,),
                      Text(
                        "Event Time",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          // Show a Time Picker
                          var timeOfDay = await showTimePicker(
                            context: context,
                            // returns with current time
                            initialTime:
                            TimeOfDay.fromDateTime(provider.selectedDate),
                          );
                          if (timeOfDay != null) {
                            final newDateTime = DateTime(
                              provider.selectedDate.year, // don't changed
                              provider.selectedDate.month, // don't changed
                              provider.selectedDate.day, // don't changed
                              timeOfDay.hour, // changed
                              timeOfDay.minute, // changed
                            );
                            provider.changeSelectedDate(newDateTime);
                          }
                        },
                        child: Text(
                          DateFormat.jm('en_US').format(provider.selectedDate),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Location".tr(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PickerLocationScreen.routeName,arguments: provider);
                    },
                    style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF5669FF),
                        side: const BorderSide(width: 3, color: Color(0xFF5669FF)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(width: 3, color: Color(0xFF5669FF)),
                        ),
                        padding: const EdgeInsets.all(8)),
                    child: Row(
                      children: [
                        Container(
                          child: const Icon(
                            Icons.gps_fixed,
                            color: Color(0xff0FFF2FEFF),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFF5669FF),
                          ),
                          padding: const EdgeInsets.all(12),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                         Expanded(
                          child: Text(
                            provider.eventLocation==null?context.tr('Choose Event Location'):"Location${provider.eventLocation!.latitude}:${provider.eventLocation!.latitude}${provider.eventLocation!.longitude}",
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF5669FF),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          EventModel task = EventModel(
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
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: const Color(0xFF5669FF)),
                        child: Text(
                          "Add Event",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                    ),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/providers/create_events_provider.dart';
import 'package:todo_c13_sun/widgets/event_category_item.dart';

class CreateEventScreen extends StatelessWidget {
  static const String routeName = "CreateEvent";

  const CreateEventScreen({super.key});

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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

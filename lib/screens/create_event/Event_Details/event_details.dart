import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show CameraPosition, GoogleMap, LatLng, MapType, Marker, MarkerId;
import 'package:todo_c13_sun/firebase/firebase_manager.dart';
import 'package:todo_c13_sun/models/task_model.dart';
import 'package:todo_c13_sun/screens/create_event/Event_Details/Widgets/date_time_card.dart';
import 'package:todo_c13_sun/screens/create_event/Event_Details/Widgets/event_location_card.dart';
import 'package:todo_c13_sun/screens/create_event/create_event.dart';

class EventDetails extends StatefulWidget {
  static const String routeName = "eventDetails";
  final EventModel eventModel;
   EventDetails({required this.eventModel, super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          "EventDetails".tr(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, CreateEventScreen.routeName);
          }, icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                _deletEvent();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        AspectRatio(
          aspectRatio: 138 / 78,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              "assets/images/${widget.eventModel.category}.png",
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "We Are Going To Play Football".tr(),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        DateTimeCard(
          date: widget.eventModel.date,
          time: widget.eventModel.time,
        ),
        const SizedBox(
          height: 16,
        ),
        EventLocationCard(latitude: widget.eventModel.latitude ,longitude:widget.eventModel.longitude ,),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).primaryColor, width: 1),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      widget.eventModel.latitude, widget.eventModel.longitude),
                  zoom: 16),
              scrollGesturesEnabled: false,
              tiltGesturesEnabled: false,
              zoomGesturesEnabled: false,
              zoomControlsEnabled: false,
              markers: {
                Marker(
                  markerId: const MarkerId("1"),
                  position: LatLng(
                      widget.eventModel.latitude, widget.eventModel.longitude),
                )
              },
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "Description".tr(),
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).primaryColor),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit eget neque senectus a. Nulla at non malesuada odio duis lectus amet nisi sit. Risus hac enim maecenas auctor et. At cras massa diam porta facilisi lacus purus. Iaculis eget quis ut amet. Sit ac malesuada nisi quis  feugiat.".tr(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ]),
    );
  }

  void _deletEvent() async {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Colors.transparent,
            title: Center(child: CircularProgressIndicator()),
          );
        });
    await FirebaseManager.deletEvent(widget.eventModel.id);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_c13_sun/firebase/firebase_manager.dart';
import 'package:todo_c13_sun/models/task_model.dart';
import 'package:todo_c13_sun/providers/maps_provider.dart';
import 'package:todo_c13_sun/screens/widgets/event_item.dart';

class MapTab extends StatefulWidget {
   MapTab({super.key});
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
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  late MapsProvider mapsProvider;



  @override
  Widget build(BuildContext context) {


    return Consumer<MapsProvider>(
      builder: (context, provider, child) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(onPressed: () {
          provider.getLocation();
        },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          child: const Icon(Icons.gps_fixed),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: provider.cameraPosition,
                    mapType: MapType.normal,
                    onMapCreated: (mapController) {
                      provider.mapController = mapController;
                    },
                    markers: provider.markers,
                  ),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot<TaskModel>>(
              stream: FirebaseManager.getEvents(""),
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
          ],
        ),
      ),
    );
  }
}

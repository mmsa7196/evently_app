
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:todo_c13_sun/models/task_model.dart';

import '../firebase/firebase_manager.dart';

class CreateEventsProvider extends ChangeNotifier {
  int selectedEventIndex = 0;
  EventModel? eventModel;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  List<String> eventsCategories = [
    "birthday".tr(),
    "book_club".tr(),
    "eating".tr(),
    "meeting".tr(),
    "exhibtion".tr(),
    "holiday".tr(),
    "sport".tr(),
    "workshop".tr(),
  ];
  var selectedDate = DateTime.now();

  String get imageName => eventsCategories[selectedEventIndex];

  String get selectedEvent => eventsCategories[selectedEventIndex];

  changeSelectedDate(DateTime date) {
    selectedDate = date;

    notifyListeners();
  }

  changeEventType(int index) {
    selectedEventIndex = index;

    notifyListeners();
  }

  Future<void> addEvent() async {
    var eventModel = EventModel(
      title: titleController.text,
      time: true,
      userId: FirebaseAuth.instance.currentUser!.uid,
      description: descriptionController.text,
      category: selectedEvent,
      date: selectedDate.millisecondsSinceEpoch,
      latitude: eventLocation!.latitude,
      longitude: eventLocation!.longitude,
      image: imageName,

    );
    await FirebaseManager.addEvent(eventModel!);
  }


  Future<void> deleteEvent() async {
    await FirebaseManager.deletEvent(eventModel!.id);
  }


  ///////Location_Picker///////
  LatLng?eventLocation;
  Location location = Location();
  late GoogleMapController mapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 18,
  );
  String locationMessage = "";
  Set<Marker> markers = {
    const Marker(
      markerId: MarkerId("2"),
      position: LatLng(37.42796133580664, -122.085749655962),
    ),
  };

  Future<void> getLocation() async {
    bool locationPermissionGranted = await _getLocationPermission();
    if (!locationPermissionGranted) {
      return;
    }
    bool locationServiceEnabled = await _locationServiceEnabled();
    if (!locationServiceEnabled) {
      return;
    }

    LocationData locationData = await location.getLocation();
    changeLocationOnMap(locationData);
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 18,
    );
    markers = {
      Marker(
        markerId: const MarkerId("2"),
        position:
        LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      )
    };
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }

  Future<bool> _getLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _locationServiceEnabled() async {
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
    }
    return locationServiceEnabled;
  }


  void changeLocationOnMap(LocationData locationData) {
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 18,
    );
    markers = {
      Marker(
        markerId: MarkerId(UniqueKey().toString()),
        position:
        LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      )
    };
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }

  void changeLocation(LatLng newEventLocation) {
    eventLocation = newEventLocation;
    notifyListeners();
  }

  void initData(EventModel event) {
    eventModel = event;
    titleController.text = event.title;
    descriptionController.text = event.description;
    eventLocation = LatLng(event.latitude, event.longitude);
    selectedDate = DateTime.fromMillisecondsSinceEpoch(event.date);
    notifyListeners();
  }

  Future<void> ubdateEvent() async {
    if (eventModel == null) {
      throw Exception("Event model is null");
    }
    if (eventLocation == null) {
      throw Exception("Event location is null");
    }

    eventModel!.title = titleController.text;
    eventModel!.time = true; // Corrected this line
    eventModel!.description = descriptionController.text;
    eventModel!.image = selectedEvent;
    eventModel!.latitude = eventLocation!.latitude;
    eventModel!.longitude = eventLocation!.longitude;
    eventModel!.date = selectedDate.millisecondsSinceEpoch;
    eventModel!.category = selectedEvent;

    await FirebaseManager.ubdateEvent(eventModel!);
  }
}


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CreateEventsProvider extends ChangeNotifier {
  int selectedEventIndex = 0;

  List<String> eventsCategories = [
    "birthday",
    "book_club",
    "eating",
    "meeting",
    "exhibtion",
    "holiday",
    "sport",
    "workshop",
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
        markerId: MarkerId("2"),
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
  void changeLocation(LatLng newEventLocation){
    eventLocation=newEventLocation;
    notifyListeners();
  }
}

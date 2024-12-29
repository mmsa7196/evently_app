import 'package:flutter/material.dart';

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

  String get imageName => eventsCategories[selectedEventIndex];
  String get selectedEvent => eventsCategories[selectedEventIndex];

  changeEventType(int index) {
    selectedEventIndex = index;

    notifyListeners();
  }
}

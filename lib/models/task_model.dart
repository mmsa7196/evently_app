class EventModel {
  String id;
  String title;
  String description;
  String image;
  String userId;
  bool isDone;
  int date;
  bool time;
  String category;
  double latitude;
  double longitude;

  EventModel({
    this.id = "",
    required this.date,
    required this.time,
    required this.image,
    required this.title,
    required this.category,
    required this.description,
    required this.userId,
    this.isDone = false,
    this.latitude = 0,
    this.longitude = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date": date,
      "time": time,
      "title": title,
      "category": category,
      "description": description,
      "userId": userId,
      "isDone": isDone,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}

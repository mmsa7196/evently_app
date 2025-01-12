class TaskModel {
  String id;
  String title;
  String description;
  bool isDone;
  int date;
  String category;

  TaskModel({
    this.id = "",
    required this.date,
    required this.title,
    required this.category,
    required this.description,
    this.isDone = false,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          date: json['date'],
          title: json['title'],
          category: json['category'],
          description: json['description'],
          isDone: json['isDone'],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date": date,
      "title": title,
      "category": category,
      "description": description,
      "isDone": isDone,
    };
  }
}

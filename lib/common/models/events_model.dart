class EventModel {
  String title;
  List<String> exercises;

  EventModel({
    required this.title,
    this.exercises = const []
  });

  EventModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        exercises = (json['exercises'] as List<dynamic>).cast<String>();

  Map<String, dynamic> toJson() => {
    'title': title,
    'exercises': exercises
  };

  @override
  String toString() => title;
}
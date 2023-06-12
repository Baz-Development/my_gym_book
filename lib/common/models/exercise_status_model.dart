
class ExercisesStatusModel {
  String exercisesId;
  String title;
  String imagePath;
  int repetitionCount;
  int series;
  String weight;
  int interval;
  bool isCompleted;

  ExercisesStatusModel({
    required this.exercisesId,
    required this.title,
    required this.imagePath,
    required this.series,
    required this.repetitionCount,
    required this.weight,
    required this.interval,
    required this.isCompleted
  });

  ExercisesStatusModel.fromJson(Map<String, dynamic> json)
      : exercisesId = json['exercisesId'],
        title = json['title'],
        imagePath = json['imagePath'],
        series = json['series'],
        repetitionCount = json['repetitionCount'],
        weight = json['weight'],
        interval = json['interval'],
        isCompleted = json['isCompleted'];

  Map<String, dynamic> toJson() => {
    'exercisesId': exercisesId,
    'title': title,
    'imagePath': imagePath,
    'series': series,
    'repetitionCount': repetitionCount,
    'weight': weight,
    'interval': interval,
    'isCompleted': isCompleted
  };
}

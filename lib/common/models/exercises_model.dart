class ExercisesModel {
  String exercisesId;
  String title;
  String imagePath;
  int repetitionCount;
  int series;
  int weight;
  int interval;
  int duration = 0;

  ExercisesModel(
    {
      required this.exercisesId,
      required this.title,
      required this.imagePath,
      required this.series,
      required this.repetitionCount,
      required this.weight,
      required this.interval,
      this.duration = 0
    }
  );

  ExercisesModel.fromJson(Map<String, dynamic> json)
      : exercisesId = json['exercisesId'],
        title = json['title'],
        imagePath = json['imagePath'],
        series = json['series'],
        repetitionCount = json['repetitionCount'],
        weight = json['weight'],
        interval = json['interval'],
        duration = json['duration'] ?? 0;

  Map<String, dynamic> toJson() => {
    'exercisesId': exercisesId,
    'title': title,
    'imagePath': imagePath,
    'series': series,
    'repetitionCount': repetitionCount,
    'weight': weight,
    'interval': interval,
    'duration': duration
  };
}

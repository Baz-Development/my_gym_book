
class ExercicesModel {
  String exercisesId;
  String title;
  String imagePath;
  int repetitionCount;
  int series;
  String weight;
  int interval;

  ExercicesModel({
    required this.exercisesId,
    required this.title,
    required this.imagePath,
    required this.series,
    required this.repetitionCount,
    required this.weight,
    required this.interval
  });

  ExercicesModel.fromJson(Map<String, dynamic> json)
      : exercisesId = json['exercisesId'],
        title = json['title'],
        imagePath = json['imagePath'],
        series = json['series'],
        repetitionCount = json['repetitionCount'],
        weight = json['weight'],
        interval = json['interval'];

  Map<String, dynamic> toJson() => {
    'exercisesId': exercisesId,
    'title': title,
    'imagePath': imagePath,
    'series': series,
    'repetitionCount': repetitionCount,
    'weight': weight,
    'interval': interval
  };
}

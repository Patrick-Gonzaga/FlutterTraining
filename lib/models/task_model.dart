class TaskModel {
  String taskName;
  DateTime dateTime;

  TaskModel.fromJson(Map<String, dynamic> json)
    : taskName = json['taskName'],
      dateTime = DateTime.parse(json['dateTime']);

  TaskModel({
    required this.taskName,
    required this.dateTime,
  });

  Map<String, dynamic> toJson(){
    return {
      'taskName': taskName,
      'dateTime': dateTime.toIso8601String()
    };
  }
}

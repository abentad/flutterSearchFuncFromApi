class Task {
  String text;
  bool isComplete;
  Task({this.text, this.isComplete});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      text: json["text"] as String,
      isComplete: json["isCompleted"] as bool,
    );
  }
}

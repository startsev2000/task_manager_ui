class Task {
  final int id;
  final int userId;
  final String title;
  final String dueOn;
  final String status;

  const Task({
    required this.id,
    required this.userId,
    required this.title,
    required this.dueOn,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      dueOn: json['due_on'],
      status: json['status'],
    );
  }
}

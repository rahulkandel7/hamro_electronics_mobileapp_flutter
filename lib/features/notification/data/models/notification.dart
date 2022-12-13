class Notification {
  final int id;
  final String title;
  final String description;
  final String date;
  Notification({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      date: map['date'] as String,
    );
  }
}

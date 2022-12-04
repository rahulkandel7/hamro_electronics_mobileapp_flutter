class Banner {
  final int id;
  final int priority;
  final String photopath;

  Banner({
    required this.id,
    required this.photopath,
    required this.priority,
  });

  factory Banner.fromMap(Map<String, dynamic> map) {
    return Banner(
      id: map['id'] as int,
      priority: int.parse(map['priority']),
      photopath: map['photopath'] as String,
    );
  }
}

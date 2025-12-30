class Subject {
  final int id;
  final String name;
  final int tutorCount;
  final String icon;
  final String startColor;
  final String endColor;

  Subject({
    required this.id,
    required this.name,
    required this.tutorCount,
    required this.icon,
    required this.startColor,
    required this.endColor,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'tutorCount': tutorCount,
    'icon': icon,
    'startColor': startColor,
    'endColor': endColor,
  };

  static Subject fromJson(dynamic json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      tutorCount: json['tutorCount'],
      icon: json['icon'],
      startColor: json['startColor'],
      endColor: json['endColor'],
    );
  }
}

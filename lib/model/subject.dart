class Subject {
  final String name;
  final int tutorCount;
  final String icon;
  final String startColor;
  final String endColor;

  Subject({
    required this.name,
    required this.tutorCount,
    required this.icon,
    required this.startColor,
    required this.endColor,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'tutorCount': tutorCount,
    'icon': icon,
    'startColor': startColor,
    'endColor': endColor,
  };

  static Subject fromJson(dynamic json) {
    return Subject(
      name: json['name'],
      tutorCount: json['tutorCount'],
      icon: json['icon'],
      startColor: json['startColor'],
      endColor: json['endColor'],
    );
  }
}

class Instructor {
  final int id;
  final String name;
  final String image;
  final String subject;
  final double rating;
  final int reviewCount;
  final bool isTopAuthor;
  final String bio;
  final int totalStudents;
  final List<int> courses;
  final String specialization;
  final String description;

  Instructor({
    required this.id,
    required this.name,
    required this.image,
    required this.subject,
    required this.rating,
    required this.reviewCount,
    required this.isTopAuthor,
    required this.bio,
    required this.totalStudents,
    required this.courses,
    required this.specialization,
    required this.description,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      subject: json['subject'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      isTopAuthor: json['isTopAuthor'] as bool,
      bio: json['bio'] as String,
      totalStudents: json['totalStudents'] as int,
      courses: List<int>.from(json['courses'] as List),
      specialization: json['specialization'] as String,
      description: json['description'] as String,
    );
  }
}

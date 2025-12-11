class Course {
  final int id;
  final String title;
  final String instructor;
  final String duration;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final bool isTopAuthor;
  final String image;
  final String description;
  final String category;
  final String level;
  final String subject;
  final DateTime createdAt;

  Course({
    required this.id,
    required this.title,
    required this.instructor,
    required this.duration,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.isTopAuthor,
    required this.image,
    required this.description,
    required this.category,
    required this.level,
    required this.subject,
    required this.createdAt,
  });

  factory Course.fromJson(dynamic json) {
    DateTime parsedDate =
        DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now();
    return Course(
      id: json['id'] as int,
      title: json['title'] as String,
      instructor: json['instructor'] as String,
      duration: json['duration'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: (json['originalPrice'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      isTopAuthor: json['isTopAuthor'] as bool,
      image: json['image'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      level: json['level'] as String,
      subject: json['subject'] as String,
      createdAt: parsedDate,
    );
  }
}
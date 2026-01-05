import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final int id;
  final String title;
  final String instructor;
  final double duration;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final bool isTopAuthor;
  final String image;
  final String description;
  final String category;
  final int level;
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
    DateTime parsedDate;

    if (json['createdAt'] is Timestamp) {
      parsedDate = (json['createdAt'] as Timestamp).toDate();
    } else if (json['createdAt'] is String) {
      parsedDate = DateTime.tryParse(json['createdAt']) ?? DateTime.now();
    } else {
      parsedDate = DateTime.now();
    }
    return Course(
      id: json['id'] as int,
      title: json['title'] as String,
      instructor: json['instructor'] as String,
      duration: (json['duration'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      originalPrice: (json['originalPrice'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      isTopAuthor: json['isTopAuthor'] as bool,
      image: json['image'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      level: json['level'] as int,
      subject: json['subject'] as String,
      createdAt: parsedDate,
    );
  }
}

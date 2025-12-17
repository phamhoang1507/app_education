import 'package:education_app/model/course.dart';
import 'package:education_app/model/instructor.dart';
import 'package:education_app/model/subject.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

Widget buildSubjectCard(Subject subject) {
  return Container(
    width: 170,
    height: 90,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [HexColor(subject.startColor), HexColor(subject.endColor)],
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: HexColor(subject.endColor).withOpacity(0.3),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Stack(
      children: [
        Positioned(
          right: 0,
          top: -20,
          child: Opacity(
            opacity: 0.1,
            child: Icon(getIcon(subject.icon), size: 80),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Icon(
                  getIcon(subject.icon),
                  color: Colors.white,
                  size: 35,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    ' - ${subject.tutorCount} Tutor',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCourseCard(Course course) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 230,
        height: 130,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(course.image, fit: BoxFit.cover),
        ),
      ),
      SizedBox(height: 8),
      Text(
        course.title,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 8),
      Row(
        children: [Text(course.instructor), Text(' - '), Text(course.duration)],
      ),
      SizedBox(height: 8),
      Container(
        width: 230,
        height: 1,
        color: Colors.grey,
        margin: const EdgeInsets.only(right: 8.0),
      ),
      SizedBox(height: 8),
      SizedBox(
        width: 230,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$${course.price.toStringAsFixed(2)}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(" \$${course.originalPrice.toStringAsFixed(0)}"),
              ],
            ),
            Row(
              children: [
                Icon(Icons.star, color: HexColor('FB923C')),
                Text(course.rating.toString()),
                SizedBox(width: 5),
                Text(
                  '(${NumberFormat('#,###').format(course.reviewCount).toString()})',
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: !course.level.contains('Beginner')
              ? Color(0xFFE7D5FF)
              : HexColor('#DCFCE7'),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(course.level),
      ),
    ],
  );
}

Widget buildInstructorCard(Instructor instructor) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey, width: 2),
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
    ),
    width: 170,
    height: 170,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: ClipOval(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              child: Image.asset(instructor.image),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          instructor.name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(instructor.subject, style: TextStyle(fontSize: 14)),
      ],
    ),
  );
}

IconData getIcon(String icon) {
  switch (icon) {
    case 'calculate':
      return Icons.calculate;
    case 'architecture':
      return Icons.architecture;
    case 'science':
      return Icons.science;
    case 'flash_on':
      return Icons.flash_on;
    default:
      return Icons.computer;
  }
}

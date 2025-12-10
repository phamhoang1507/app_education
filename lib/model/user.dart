import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String? photoURL;
  final String? phoneNumber;
  final bool emailVerified;
  final DateTime? createdAt;
  final DateTime? lastLogin;
  final String? providerId;
  final String? locale;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoURL,
    this.phoneNumber,
    this.emailVerified = false,
    this.createdAt,
    this.lastLogin,
    this.providerId,
    this.locale,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      email: json["email"],
      displayName: json["displayName"],
      photoURL: json["photoURL"],
      phoneNumber: json["phoneNumber"],
      emailVerified: json["emailVerified"] ?? false,

      createdAt: json["createdAt"] != null
          ? (json["createdAt"] is Timestamp
                ? (json["createdAt"] as Timestamp).toDate()
                : DateTime.parse(
                    json["createdAt"],
                  )) // phòng trường hợp là string
          : null,

      lastLogin: json["lastLogin"] != null
          ? (json["lastLogin"] is Timestamp
                ? (json["lastLogin"] as Timestamp).toDate()
                : DateTime.parse(json["lastLogin"]))
          : null,

      providerId: json["providerId"],
      locale: json["locale"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "displayName": displayName,
      "photoURL": photoURL,
      "phoneNumber": phoneNumber,
      "emailVerified": emailVerified,
      "createdAt": createdAt?.toIso8601String(),
      "lastLogin": lastLogin?.toIso8601String(),
      "providerId": providerId,
      "locale": locale,
    };
  }
}

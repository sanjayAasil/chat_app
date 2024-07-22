import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String userId;
  final String name;
  final String? email;
  final String phoneNumber;
  final String? profilePictureUrl;
  final String about;
  final DateTime lastSeen;

  UserModel({
    this.email,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    this.profilePictureUrl,
    this.about = "Hey there!, I'm using ChatApp",
    required this.lastSeen,
  });

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'profilePictureUrl': profilePictureUrl,
        'status': about,
        'lastSeen': lastSeen.toIso8601String(),
      };

  // Method to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json['userId'],
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        profilePictureUrl: json['profilePictureUrl'],
        about: json['status'],
        lastSeen: DateTime.parse(json['lastSeen']),
      );

  UserModel copyWith({
    String? userId,
    String? name,
    String? email,
    String? phoneNumber,
    String? profilePictureUrl,
    String? status,
    DateTime? lastSeen,
  }) =>
      UserModel(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
        about: status ?? this.about,
        lastSeen: lastSeen ?? this.lastSeen,
      );
}

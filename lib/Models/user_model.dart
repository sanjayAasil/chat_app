class UserModel {
  final String userId;
  final String name;
  final String? email;
  final String phoneNumber;
  final String? profilePictureUrl;
  final String? status;
  final DateTime lastSeen;

  UserModel({
    this.email,
    required this.userId,
    required this.name,
    required this.phoneNumber,
    this.profilePictureUrl,
    this.status,
    required this.lastSeen,
  });

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'profilePictureUrl': profilePictureUrl,
        'status': status,
        'lastSeen': lastSeen.toIso8601String(),
      };

  // Method to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json['userId'],
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        profilePictureUrl: json['profilePictureUrl'],
        status: json['status'],
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
        status: status ?? this.status,
        lastSeen: lastSeen ?? this.lastSeen,
      );
}

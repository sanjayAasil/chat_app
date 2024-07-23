class MessageModel {
  final String message;
  final String senderId;
  final String receiverId;
  final DateTime timeStamp;
  final bool isRead;

  MessageModel({
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.timeStamp,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() => {
        'message': message,
        'senderId': senderId,
        'receiverId': receiverId,
        'timeStamp': timeStamp.toIso8601String(),
        'isRead': isRead,
      };

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
      message: json['message'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      timeStamp: DateTime.parse(json['timeStamp']),
      isRead: json['isRead']);
}

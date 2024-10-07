
class MessageModel {
  final String message;
  final String senderId;
  final String receiverId;
  final DateTime timeStamp = DateTime.now();
  final bool isRead;

  MessageModel({
    required this.message,
    required this.senderId,
    required this.receiverId,
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
        isRead: json['isRead'],
      );
}

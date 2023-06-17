
class Chat {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime sentTime;

  const Chat({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.sentTime,
  });

  Chat copyWith({
    final String? id,
    final String? senderId,
    final String? receiverId,
    final String? message,
    final DateTime? sentTime,
  }) =>
      Chat(
        id: id ?? this.id,
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        message: message ?? this.message,
        sentTime: sentTime ?? this.sentTime,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'senderId': senderId,
        'receiverId': receiverId,
        'message': message,
        'sentTime': sentTime.millisecondsSinceEpoch,
      };

  factory Chat.fromMap(Map<String, dynamic> map) => Chat(
        id: map['id'] ?? '',
        senderId: map['senderId'] ?? '',
        receiverId: map['receiverId'] ?? '',
        message: map['message'] ?? '',
        sentTime: DateTime.fromMillisecondsSinceEpoch(map['sentTime']),
      );


  @override
  String toString() => 'Chat(id: $id, senderId: $senderId, receiverId: $receiverId, message: $message, sentTime: $sentTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chat &&
        other.id == id &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.message == message &&
        other.sentTime == sentTime;
  }

  @override
  int get hashCode => id.hashCode ^
        senderId.hashCode ^
        receiverId.hashCode ^
        message.hashCode ^
        sentTime.hashCode;
}

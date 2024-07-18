class ChatMessageEntity {
  final String text;
  final bool isSentByMe;

  ChatMessageEntity({required this.text, this.isSentByMe = true});
}

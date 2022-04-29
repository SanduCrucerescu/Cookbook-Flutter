class DirectMessage {
  final String sender;
  final String receiver;
  final String content;
  final String time;
  final String date;

  DirectMessage(
      {required this.sender,
      required this.receiver,
      required this.content,
      required this.time,
      required this.date});
}

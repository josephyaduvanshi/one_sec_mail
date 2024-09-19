class Message {
  final int id;
  final String from;
  final String subject;
  final String date;

  Message({
    required this.id,
    required this.from,
    required this.subject,
    required this.date,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as int,
      from: json['from'] as String,
      subject: json['subject'] as String,
      date: json['date'] as String,
    );
  }

  @override
  String toString() {
    return 'Message(id: $id, from: $from, subject: $subject, date: $date)';
  }
}

import 'attachment_details.dart';

class MessageDetails {
  final int id;
  final String from;
  final String subject;
  final String date;
  final List<Attachment> attachments;
  final String body;
  final String textBody;
  final String htmlBody;

  MessageDetails({
    required this.id,
    required this.from,
    required this.subject,
    required this.date,
    required this.attachments,
    required this.body,
    required this.textBody,
    required this.htmlBody,
  });

  factory MessageDetails.fromJson(Map<String, dynamic> json) {
    var attachmentsJson = json['attachments'] as List<dynamic>;
    List<Attachment> attachmentsList = attachmentsJson
        .map((attachmentJson) => Attachment.fromJson(attachmentJson))
        .toList();

    return MessageDetails(
      id: json['id'] as int,
      from: json['from'] as String,
      subject: json['subject'] as String,
      date: json['date'] as String,
      attachments: attachmentsList,
      body: json['body'] as String,
      textBody: json['textBody'] as String,
      htmlBody: json['htmlBody'] as String,
    );
  }

  @override
  String toString() {
    return 'MessageDetails(id: $id, from: $from, subject: $subject, date: $date, attachments: $attachments)';
  }
}

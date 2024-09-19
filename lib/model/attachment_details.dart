class Attachment {
  final String filename;
  final String contentType;
  final int size;

  Attachment({
    required this.filename,
    required this.contentType,
    required this.size,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      filename: json['filename'] as String,
      contentType: json['contentType'] as String,
      size: json['size'] as int,
    );
  }

  @override
  String toString() {
    return 'Attachment(filename: $filename, contentType: $contentType, size: $size)';
  }
}

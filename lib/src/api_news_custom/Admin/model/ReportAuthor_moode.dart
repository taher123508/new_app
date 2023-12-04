
class AuthorsLogView {
  String logLevel;
  String content;
  String authorId;
  String dateCreated;

  AuthorsLogView({
    required this.logLevel,
    required this.content,
    required this.authorId,
    required this.dateCreated,
  });
  factory AuthorsLogView.fromJson(Map<String, dynamic> json) {
    return AuthorsLogView(
      logLevel: json['logLevel'],
      content: json['content'],
      authorId: json['authorId'],
      dateCreated: json['dateCreated'],

    );
  }

}

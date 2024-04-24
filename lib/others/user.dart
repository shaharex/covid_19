class User {
  final String image;
  final String title;
  final String summary;
  final String content;

  const User({
    required this.image,
    required this.title,
    required this.summary,
    required this.content,
  });

  static User fromJson(json) => User(
        image: json["image"],
        title: json["title"],
        summary: json["summary"],
        content: json["content"],
      );
}

class Tweet{
  int id;
  String author;
  String message;

  Tweet({
    required this.id,
    required this.author,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'author': this.author,
      'message': this.message,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      id: map['id'] as int,
      author: map['author'] as String,
      message: map['message'] as String,
    );
  }
}
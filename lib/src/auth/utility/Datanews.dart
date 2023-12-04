class Article {
  final int id;
  final String title;
  final String content;
  final int viewCount;
  final String publishDate;
  final int categoryId;
  final String authorDisplayName;
  final String profilePicture;
  final List<String> images;
  final List<Like> likes;
  final List<Comment> comments;

  Article({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.content,
    required this.viewCount,
    required this.publishDate,
    required this.authorDisplayName,
    required this.profilePicture,
    required this.images,
    required this.likes,
    required this.comments,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      categoryId: json['categoryId'],
      content: json['content'],
      viewCount: json['viewCount'],
      publishDate: json['publishDate'],
      authorDisplayName: json['authorDisplayName'],
      profilePicture: json['profilePicture'],
      images: List<String>.from(json['images'].map((image) => image['imageUrl'])),
      likes: List<Like>.from(json['likes'].map((like) => Like.fromJson(like))),
      comments: List<Comment>.from(json['comments'].map((comment) => Comment.fromJson(comment))),
    );
  }
}

class Like {
  final int? id;
  final int articleId;
  final int userId;
  final String userDisplayName;
  final String userProfilePicture;

  Like({
     this.id,
    required this.articleId,
    required this.userId,
    required this.userDisplayName,
    required this.userProfilePicture,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['id'],
      articleId: json['articleId'],
      userId: json['userId'],
      userDisplayName: json['userDisplayName'],
      userProfilePicture: json['userProfilePicture'],
    );
  }
}

class Comment {
   int? id;
  final int articleId;
  final int userId;
  final String commentText;
  final String userDisplayName;
  final String userProfilePicture;

  Comment({
     this.id,
    required this.articleId,
    required this.userId,
    required this.commentText,
    required this.userDisplayName,
    required this.userProfilePicture,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      articleId: json['articleId'],
      userId: json['userId'],
      commentText: json['commentText'],
      userDisplayName: json['userDisplayName'],
      userProfilePicture: json['userProfilePicture'],
    );
  }
}
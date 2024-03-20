import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  Meta meta;
  List<Result> result;

  PostModel({
    required this.meta,
    required this.result,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    meta: Meta.fromJson(json["meta"]),
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Meta {
  int? code;
  bool? status;
  String? message;

  Meta({
    required this.code,
    required this.status,
    required this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    code: json["code"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
  };
}

class Result {
  int? id;
  int? userId;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? likesCount;
  int? commentsCount;
  User? user;
  List<User>? comments;

  Result({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.likesCount,
    required this.commentsCount,
    required this.user,
    required this.comments,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    userId: json["user_id"],
    content: json["content"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    likesCount: json["likes_count"],
    commentsCount: json["comments_count"],
    user: User.fromJson(json["user"]),
    comments: List<User>.from(json["comments"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "content": content,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "likes_count": likesCount,
    "comments_count": commentsCount,
    "user": user!.toJson(),
    "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
  };
}

class User {
  int? id;
  String? name;
  String? username;
  String? email;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.pivot,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "pivot": pivot?.toJson(),
  };
}

class Pivot {
  int feedId;
  int userId;
  String body;
  DateTime createdAt;
  DateTime updatedAt;

  Pivot({
    required this.feedId,
    required this.userId,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    feedId: json["feed_id"],
    userId: json["user_id"],
    body: json["body"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "feed_id": feedId,
    "user_id": userId,
    "body": body,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

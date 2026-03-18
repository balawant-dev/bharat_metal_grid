class PostReactionModel {
  final int postId;
  final int userId;
  final String reactionType;
  final bool success;

  PostReactionModel({
    required this.postId,
    required this.userId,
    required this.reactionType,
    required this.success,
  });

  factory PostReactionModel.fromJson(Map<String, dynamic> json) {
    return PostReactionModel(
      postId: json['postId'] ?? 0,
      userId: json['userId'] ?? 0,
      reactionType: json['reactionType'] ?? '',
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'userId': userId,
      'reactionType': reactionType,
      'success': success,
    };
  }
}
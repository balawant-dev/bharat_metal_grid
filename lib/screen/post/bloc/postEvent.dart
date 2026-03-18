
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object?> get props => [];
}

class ResetPostEvent extends PostEvent {
  const ResetPostEvent();
}
class CreateOrderEvent extends PostEvent {
  final BuildContext context;
  final String membershipPlanID;


  const CreateOrderEvent({
    required this.context,
    required this.membershipPlanID,

  });

  @override
  List<Object?> get props => [context, membershipPlanID];
}
class FetchPostsEvent extends PostEvent {
  final BuildContext context;
  const FetchPostsEvent({required this.context});
  @override
  List<Object?> get props => [context];
}class MembershipAssignmentEvent extends PostEvent {
  final BuildContext context;
  const MembershipAssignmentEvent({required this.context});
  @override
  List<Object?> get props => [context];
}

class FetchPostDetailEvent extends PostEvent {
  final BuildContext context;
  final String id;
  const FetchPostDetailEvent({required this.context, required this.id});
  @override
  List<Object?> get props => [context, id];
}

class CreatePostEvent extends PostEvent {
  final BuildContext context;
  final String title;
  final String description;
  final File? imageFile;

  const CreatePostEvent({
    required this.context,
    required this.title,
    required this.description,
    this.imageFile,
  });

  @override
  List<Object?> get props => [context, title, description, imageFile];
}

class ReactToPostEvent extends PostEvent {
  final BuildContext context;
  final String postId;
  final String reactionType; // "like", "unlike", "dislike" ...

  const ReactToPostEvent({
    required this.context,
    required this.postId,
    required this.reactionType,
  });

  @override
  List<Object?> get props => [context, postId, reactionType];
}

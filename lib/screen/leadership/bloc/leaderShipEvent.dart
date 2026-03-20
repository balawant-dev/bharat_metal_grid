import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LeaderShipEvent extends Equatable {
  const LeaderShipEvent();

  @override
  List<Object?> get props => [];
}

class FetchLeaderShipEvent extends LeaderShipEvent {
  final BuildContext context;

  const FetchLeaderShipEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class PostLeaderShipSummitedEvent extends LeaderShipEvent {
  final BuildContext context;
  final String name;
  final String designation;//  enum: ["President", "Vice-President", "Secretary", "Treasurer"],

  final File? profileImg ;

  const PostLeaderShipSummitedEvent({
    required this.name,
    required this.designation,
    required this.profileImg,

    required this.context,
  });

  @override
  List<Object?> get props => [
    name,
    context,
    designation,
    profileImg,





  ];
}
class ResetLeaderShipEvent extends LeaderShipEvent {
  const ResetLeaderShipEvent();
}








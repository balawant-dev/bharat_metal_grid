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

class ResetLeaderShipEvent extends LeaderShipEvent {
  const ResetLeaderShipEvent();
}








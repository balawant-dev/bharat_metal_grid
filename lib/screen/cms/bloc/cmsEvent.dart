import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CMSEvent extends Equatable{
  CMSEvent();
  @override
  List<Object?> get props => [];
}

class FetchCMSEvent extends CMSEvent{
  final BuildContext context;


  FetchCMSEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class ResetCMSEvent extends CMSEvent {
   ResetCMSEvent();
}
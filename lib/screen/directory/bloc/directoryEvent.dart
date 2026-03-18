import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DirectoryEvent extends Equatable{
  DirectoryEvent();
  @override
  List<Object?> get props => [];
}

class FetchDirectoryEvent extends DirectoryEvent{
  final BuildContext context;


  FetchDirectoryEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class ResetDirectoryEvent extends DirectoryEvent {
   ResetDirectoryEvent();
}
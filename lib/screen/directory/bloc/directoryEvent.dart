import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DirectoryEvent extends Equatable{
  DirectoryEvent();
  @override
  List<Object?> get props => [];
}

class FetchDirectoryEvent extends DirectoryEvent{
  final BuildContext context;
  final String id;


  FetchDirectoryEvent({required this.context,required this.id});

  @override
  List<Object?> get props => [context,id];
}

class ResetDirectoryEvent extends DirectoryEvent {
   ResetDirectoryEvent();
}
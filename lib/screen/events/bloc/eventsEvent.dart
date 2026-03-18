import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EventsEvent extends Equatable{
  EventsEvent();
  @override
  List<Object?> get props => [];
}

class FetchEventsEvent extends EventsEvent{
  final BuildContext context;


  FetchEventsEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

class ResetEventsEvent extends EventsEvent {
   ResetEventsEvent();
}
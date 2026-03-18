import 'package:equatable/equatable.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object> get props => [];
}

class ChangeTabEvent extends BottomNavEvent {
  final int index;

  const ChangeTabEvent(this.index);

  @override
  List<Object> get props => [index];
}
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class FetchSettingsEvent extends SettingsEvent {
  final BuildContext context; // "privacy" or "terms"

  const FetchSettingsEvent(this.context);

  @override
  List<Object?> get props => [context];
}

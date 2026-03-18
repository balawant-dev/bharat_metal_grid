import 'package:equatable/equatable.dart';

abstract class GeminiEvent extends Equatable {
  const GeminiEvent();

  @override
  List<Object?> get props => [];
}

class SendMessageEvent extends GeminiEvent {
  final String message;

  const SendMessageEvent(this.message);

  @override
  List<Object?> get props => [message];
}

class ClearChatEvent extends GeminiEvent {}

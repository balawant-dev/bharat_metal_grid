import 'package:equatable/equatable.dart';

class GeminiState extends Equatable {
  final List<Map<String, String>> messages;
  final bool isLoading;

  const GeminiState({
    this.messages = const [],
    this.isLoading = false,
  });

  GeminiState copyWith({
    List<Map<String, String>>? messages,
    bool? isLoading,
  }) {
    return GeminiState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading];
}

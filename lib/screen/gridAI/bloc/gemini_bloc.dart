import 'package:flutter_bloc/flutter_bloc.dart';
import '../geminiService/geminiService.dart';
import 'gemini_event.dart';
import 'gemini_state.dart';


class GeminiBloc extends Bloc<GeminiEvent, GeminiState> {
  final GeminiService service=GeminiService();

  GeminiBloc() : super(const GeminiState()) {
    on<SendMessageEvent>(_onSendMessage);
    on<ClearChatEvent>(_onClearChat);
  }

  Future<void> _onSendMessage(
      SendMessageEvent event,
      Emitter<GeminiState> emit,
      ) async {
    if (event.message.trim().isEmpty) return;

    final updatedMessages = List<Map<String, String>>.from(state.messages)
      ..add({"role": "user", "content": event.message});

    emit(state.copyWith(
      messages: updatedMessages,
      isLoading: true,
    ));

    try {
      final response = await service.sendPrompt(event.message);

      updatedMessages.add({
        "role": "model",
        "content": response,
      });
    } catch (e) {
      updatedMessages.add({
        "role": "system",
        "content": "Error occurred: $e",
      });
    }

    emit(state.copyWith(
      messages: updatedMessages,
      isLoading: false,
    ));
  }

  void _onClearChat(
      ClearChatEvent event,
      Emitter<GeminiState> emit,
      ) {
    emit(const GeminiState());
  }
}

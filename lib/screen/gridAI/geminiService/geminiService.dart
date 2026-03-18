import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class GeminiService {
  static const String apiKey = "AIzaSyDnJuu4xWVwf9qnAeJLU91rCYcNJEOPVx8";

  static const String model = "gemini-2.5-flash";


  static String get apiUrl =>
      "https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey";

  Future<String> sendPrompt(String prompt) async {
    final requestBody = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {"text": prompt}
          ]
        }
      ],
      "generationConfig": {
        "temperature": 0.9,
        "topP": 0.95,
        "topK": 64,
        "maxOutputTokens": 2048,
      },

    };

    try {
      debugPrint("🔗 Gemini URL: $apiUrl");
      debugPrint("📤 Request: ${jsonEncode(requestBody)}");

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      debugPrint("📥 Status: ${response.statusCode}");
      debugPrint("📥 Response: ${response.body}");

      if (response.statusCode != 200) {
        return "Error ${response.statusCode}: ${response.body}";
      }

      final data = jsonDecode(response.body);

      if (data["candidates"] != null && data["candidates"].isNotEmpty) {
        final parts = data["candidates"][0]["content"]["parts"];
        if (parts != null && parts.isNotEmpty) {
          final text = parts[0]["text"] as String?;
          if (text != null && text.isNotEmpty) {
            debugPrint("🤖 Reply: $text");
            return text;
          }
        }
      }

      debugPrint("❌ No candidates or empty response");
      return "Sorry, I couldn't get a response from Gemini.";
    } catch (e, stack) {
      debugPrint("❌ Gemini Exception: $e");
      debugPrint("Stack: $stack");
      return "Error: $e";
    }
  }
}
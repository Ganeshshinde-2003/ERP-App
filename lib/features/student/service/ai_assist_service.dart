import 'dart:convert';
import 'package:erp_app/constant/data/global_variable.dart';
import 'package:erp_app/features/student/screens/ai_assist_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final aiAssistServiceProvider = Provider((ref) => AiAssistService());

class AiAssistService {
  Future<String> sendtoDistil(String input) async {
    final apiUrl = Uri.parse(
        "https://api-inference.huggingface.co/models/j-hartmann/emotion-english-distilroberta-base");
    final headers = {
      "Authorization": "Bearer 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",
      "Content-Type": "application/json"
    };
    final payload = {"inputs": input};
    final response =
        await http.post(apiUrl, headers: headers, body: json.encode(payload));
    final List<dynamic> parsedResponse = jsonDecode(response.body);
    String reply = parsedResponse[0].toString();

    return reply;
  }

  Future<String> sendtoFinbertTone(String input) async {
    final apiUrl = Uri.parse(
        "https://api-inference.huggingface.co/models/yiyanghkust/finbert-tone");
    final headers = {
      "Authorization": "Bearer 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",
      "Content-Type": "application/json"
    };

    final payload = {"inputs": input};
    final response =
        await http.post(apiUrl, headers: headers, body: json.encode(payload));
    final List<dynamic> parsedResponse = jsonDecode(response.body);
    String reply = parsedResponse[0].toString();

    return reply;
  }

  Future<String> sendtoGPT(String message, List<Chat> chats) async {
    Uri url = Uri.parse("https://api.openai.com/v1/chat/completions");

    List<Map<String, dynamic>> jsonList = chats
        .map((chat) {
          return {
            "role": chat.isimage
                ? "system"
                : chat.isME
                    ? "user"
                    : "assistant",
            "content": chat.isimage
                ? 'For above message dalle API was used to generate an image'
                : chat.text,
          };
        })
        .toList()
        .reversed
        .toList();

    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": jsonList,
      "max_tokens": 300,
    };
    final response = await http.post(url, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $API"
    });
    final Map<String, dynamic> parsedResponse = jsonDecode(response.body);
    print(parsedResponse);

    if (parsedResponse['choices'] != null &&
        parsedResponse['choices'].isNotEmpty &&
        parsedResponse['choices'][0]['message'] != null &&
        parsedResponse['choices'][0]['message']['content'] != null) {
      String reply = parsedResponse['choices'][0]['message']['content'];
      return reply;
    } else {
      return 'Error: Invalid JSON structure';
    }
  }

  Future<String> sendtoSummary(String input) async {
    final apiUrl = Uri.parse(
        "https://api-inference.huggingface.co/models/sshleifer/distilbart-cnn-12-6");
    final headers = {
      "Authorization": "Bearer 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",
      "Content-Type": "application/json"
    };

    final payload = {"inputs": input};
    final response =
        await http.post(apiUrl, headers: headers, body: json.encode(payload));
    final List<dynamic> parsedResponse = jsonDecode(response.body);
    String reply = parsedResponse[0]['summary_text'].toString();
    return reply;
  }

  Future<String> sendtodalle(String message) async {
    Uri url = Uri.parse("https://api.openai.com/v1/images/generations");
    Map<String, dynamic> body = {"prompt": message, "n": 1, "size": "512x512"};

    final response = await http.post(url, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $API"
    });
    final Map<String, dynamic> parsedResponse = jsonDecode(response.body);
    String reply = parsedResponse['data'][0]['url'];

    return reply;
  }

  Future<String> sendtoCompVis(String input) async {
    final apiUrl = Uri.parse(
        "https://api-inference.huggingface.co/models/CompVis/stable-diffusion-v1-4");
    final headers = {
      "Authorization": "Bearer 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",
      "Content-Type": "application/json",
    };

    final payload = {"inputs": input};
    final response =
        await http.post(apiUrl, headers: headers, body: json.encode(payload));
    final imageBytes = response.bodyBytes;

    if (response.statusCode == 200) {
      return imageBytes.toString();
    } else {
      throw Exception("Failed to query API. ${response.body}");
    }
  }

  Future<String> sendtoOpenJourney(String input) async {
    final apiUrl = Uri.parse(
        "https://api-inference.huggingface.co/models/prompthero/openjourney-v4");
    final headers = {
      "Authorization": "Bearer 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",
      "Content-Type": "application/json",
    };

    final payload = {"inputs": input};
    final response =
        await http.post(apiUrl, headers: headers, body: json.encode(payload));
    final imageBytes = response.bodyBytes;

    if (response.statusCode == 200) {
      return imageBytes.toString();
    } else {
      throw Exception("Failed to query API. ${response.body}");
    }
  }
}

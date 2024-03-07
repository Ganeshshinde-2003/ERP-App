import 'package:erp_app/features/student/screens/ai_assist_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:erp_app/features/student/service/ai_assist_service.dart';

final aiAssistControllerProvider = Provider((ref) {
  final aiAssistService = ref.watch(aiAssistServiceProvider);
  return AiAssistController(assistService: aiAssistService, ref: ref);
});

class AiAssistController {
  final AiAssistService assistService;
  final ProviderRef ref;

  AiAssistController({
    required this.assistService,
    required this.ref,
  });

  Future<String> sendToDistil(String input) {
    return assistService.sendtoDistil(input);
  }

  Future<String> sendToFinbertTone(String input) {
    return assistService.sendtoFinbertTone(input);
  }

  Future<String> sendToGPT(String message, List<Chat> chats) {
    return assistService.sendtoGPT(message, chats);
  }

  Future<String> sendToSummary(String input) {
    return assistService.sendtoSummary(input);
  }

  Future<String> sentToDalle(String message) {
    return assistService.sendtodalle(message);
  }

  Future<String> sendToCompVis(String input) {
    return assistService.sendtoCompVis(input);
  }

  Future<String> sendToOpenJourney(String input) {
    return assistService.sendtoOpenJourney(input);
  }
}

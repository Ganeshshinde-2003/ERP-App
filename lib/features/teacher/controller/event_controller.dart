import 'package:erp_app/constant/models/events_model.dart';
import 'package:erp_app/features/teacher/service/event_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventsControllerProvider = Provider((ref) {
  final eventsService = ref.watch(eventServiceProvider);
  return EventsController(eventsService: eventsService, ref: ref);
});

class EventsController {
  final EventsService eventsService;
  final ProviderRef ref;

  EventsController({required this.eventsService, required this.ref});

  Future<EventsModel?> fetchEvents(BuildContext context, String who) async {
    return await eventsService.fetchEvents(context: context, who: who);
  }
}

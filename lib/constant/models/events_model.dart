class Event {
  final String id;
  final String eventName;
  final String eventType;
  final DateTime eventDate;
  final String description;
  final String organizer;
  final String location;
  final String eventStatus;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.eventName,
    required this.eventType,
    required this.eventDate,
    required this.description,
    required this.organizer,
    required this.location,
    required this.eventStatus,
    required this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      eventName: json['eventName'],
      eventType: json['eventType'],
      eventDate: DateTime.parse(json['eventDate']),
      description: json['description'],
      organizer: json['organizer'],
      location: json['location'],
      eventStatus: json['eventStatus'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class EventsModel {
  final bool success;
  final String message;
  final List<Event> data;

  EventsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    List<Event> eventsList = List<Event>.from(
      (json['data'] as List).map((event) => Event.fromJson(event)),
    );

    return EventsModel(
      success: json['success'],
      message: json['message'],
      data: eventsList,
    );
  }
}

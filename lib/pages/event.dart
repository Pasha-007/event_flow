import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  late DateTime date;
  late String name;

  // Constructor
  Event({
    required this.date,
    required this.name,
  });

  // Factory constructor to create an Event from Firestore data
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      date: (json['date'] as Timestamp).toDate(),
      name: json['name'] as String,
    );
  }
}

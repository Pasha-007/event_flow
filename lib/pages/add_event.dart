import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final TextEditingController _eventNameController = TextEditingController();

  void _saveEvent() {
    // Get the event name from the text controller
    String eventName = _eventNameController.text.trim();

    // Validate if the event name is not empty
    if (eventName.isNotEmpty) {
      // Save the event data to Firestore
      FirebaseFirestore.instance.collection('events').add({
        'name': eventName,
        'date': DateTime.now(), // You may want to replace this with the selected date
        // Add any other fields you need
      });

      // Optionally, you can navigate back to the home page after saving
      Navigator.pop(context);
    } else {
      // Show an error message or handle empty event name
      // You can customize this based on your requirements
      print('Event name cannot be empty.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: _eventNameController,
            decoration: const InputDecoration(labelText: 'Event Name'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveEvent,
            child: const Text('Save Event'),
          ),
        ],
      ),
    );
  }
}

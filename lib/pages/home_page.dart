import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';

import 'add_event.dart';
import 'event.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  DateTime today = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Event>> events = {};

  @override
  void initState() {
    super.initState();
    // Fetch events from Firestore when the widget is initialized
    fetchEventsFromFirestore();
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> fetchEventsFromFirestore() async {
    try {
      // Retrieve events from Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('events').get();

      // Update the events map based on the retrieved data
      events = {};
      for (var doc in querySnapshot.docs) {
        Event event = Event.fromJson(doc.data());
        DateTime date = event.date;
        events.update(date, (existingEvents) => [...existingEvents, event],
            ifAbsent: () => [event]);
      }

      // Force a rebuild to reflect the updated events on the calendar
      setState(() {});
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x000ffccc),
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Content(),
    );
  }

  Widget Content() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Container(
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,
            ),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddEvent()),
              ).then((_) {
                // Update events after returning from AddEvent page
                fetchEventsFromFirestore();
              });
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: events[today]?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(events[today]![index].name),
                  // Add any other fields you want to display
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

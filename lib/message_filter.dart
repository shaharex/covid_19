import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filtering Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FilteringPage(),
    );
  }
}

class Events {
  final String name;
  final bool isRead;

  Events({required this.name, required this.isRead});

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      name: json['name'],
      isRead: json['isRead'],
    );
  }
}

class FilteringPage extends StatefulWidget {
  @override
  _FilteringPageState createState() => _FilteringPageState();
}

class _FilteringPageState extends State<FilteringPage> {
  late Future<List<Events>> eventsFuture;
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    eventsFuture = getEvents(context);
  }

  static Future<List<Events>> getEvents(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data =
        await assetBundle.loadString("events_resources/json/events_data.json");
  
    final body = jsonDecode(data);
    return List<Events>.from(body.map((dynamic item) => Events.fromJson(item)));
  }

  List<Events> filterEvents(List<Events> events) {
    if (selectedFilter == 'All') {
      return events;
    } else if (selectedFilter == 'Unread') {
      return events.where((event) => !event.isRead).toList();
    } else if (selectedFilter == 'Read') {
      return events.where((event) => event.isRead).toList();
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtering Example'),
      ),
      body: FutureBuilder<List<Events>>(
        future: eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Events> events = snapshot.data ?? [];
            List<Events> filteredEvents = filterEvents(events);

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedFilter = 'All';
                        });
                      },
                      child: Text('All'),
                      style: selectedFilter == 'All'
                          ? TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                            )
                          : null,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedFilter = 'Unread';
                        });
                      },
                      child: Text('Unread'),
                      style: selectedFilter == 'Unread'
                          ? TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                            )
                          : null,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedFilter = 'Read';
                        });
                      },
                      child: Text('Read'),
                      style: selectedFilter == 'Read'
                          ? TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                            )
                          : null,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredEvents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(filteredEvents[index].name),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

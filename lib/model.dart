import 'package:flutter/foundation.dart';

class Event {
  final String name;
  final String date;
  Event({this.name, this.date});
}

class Events extends ChangeNotifier {
  List<Event> _events = [];
  List<Event> get events => _events;
  void add(event) {
    _events.add(event);
    notifyListeners();
  }

  void remove(Event event) {
    _events
        .removeWhere((evt) => event.name == evt.name && event.date == evt.date);
    notifyListeners();
  }
}

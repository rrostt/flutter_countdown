import 'package:countdown/views/event_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../model.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EventList(),
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.of(context).pushNamed('/add');
          if (result != null) {
            Provider.of<Events>(context, listen: false).add(result);
          }
        },
      ),
    );
  }
}

class EventList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var events = useListenable(Provider.of<Events>(context));
    return events.events.length > 0
        ? _eventList(context, events)
        : _emptyList();
  }

  Widget _eventList(context, Events events) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 112),
      itemCount: events.events.length,
      itemBuilder: (context, index) => Dismissible(
        key: Key(events.events[index].name),
        onDismissed: (direction) {
          events.remove(events.events[index]);
        },
        child: _event(context, events.events[index]),
      ),
    );
  }

  Widget _emptyList() {
    return Padding(
      padding: const EdgeInsets.all(37),
      child: Text(
        'Lägg till händelser genom att trycka på plus.',
        style: TextStyle(
          fontSize: 64,
          color: Color.fromARGB(52, 0, 0, 0),
        ),
      ),
    );
  }

  Widget _event(context, event) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EventView(event)));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(event.name,
                style: TextStyle(fontSize: 14, color: Color(0xA6000000))),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 4),
              padding: EdgeInsets.fromLTRB(19, 10, 19, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(64, 0, 0, 0),
                    offset: Offset(0, 2),
                    blurRadius: 2,
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(event.date, style: TextStyle(fontSize: 36)),
            ),
          ],
        ),
      ),
    );
  }
}

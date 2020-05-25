import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';

import '../widgets/button.dart';
import '../model.dart';

class AddEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Stack(
        children: [
          Positioned.fill(
            top: 112,
            child: SingleChildScrollView(
              child: AddEventForm(),
            ),
          ),
          Positioned(
            top: 19,
            right: 11,
            child: Opacity(
              opacity: 0.4,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddEventForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var nameController = useTextEditingController(text: '');
    var date = useState(DateTime.now());

    return Column(
      children: <Widget>[
        _formField(
          label: 'Name of event',
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
        _formField(
          label: 'Date',
          child: DateField(
            onDateSelected: (newDate) {
              date.value = newDate;
            },
            selectedDate: date.value,
            label: null,
            dateFormat: DateFormat('y-MM-dd'),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            firstDate: DateTime.now(),
          ),
        ),
        Button(
          child: Text(
            'Spara',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop(
              Event(
                  name: nameController.text,
                  date: DateFormat('yyyy-MM-dd').format(date.value)),
            );
          },
        ),
      ],
    );
  }

  Widget _formField({String label, Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: TextStyle(fontSize: 14, color: Color(0xA6000000))),
          Container(
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
              child: child),
        ],
      ),
    );
  }
}

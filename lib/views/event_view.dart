import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../model.dart';

class EventView extends HookWidget {
  final Event event;

  EventView(this.event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Stack(
        children: [
          CountersColumn(event.name, event.date),
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

class CountersColumn extends HookWidget {
  final String date;
  final String name;

  CountersColumn(this.name, this.date);

  @override
  Widget build(BuildContext context) {
    var now = useState(DateTime.now());
    var datetime = DateTime.parse(date);
    var difference = datetime.difference(now.value);
    var days = difference.inDays;
    var hours = difference.inHours % 24;
    var minutes = difference.inMinutes % 60;
    var seconds = difference.inSeconds % 60;

    useEffect(() {
      var timer = Timer.periodic(Duration(seconds: 1), (timer) {
        now.value = DateTime.now();
      });
      return () {
        timer.cancel();
      };
    }, []);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _eventName(name),
        _label('days'),
        Count(days.toString()),
        _label('hours'),
        Count(hours.toString().padLeft(2, '0')),
        _label('minutes'),
        Count(minutes.toString().padLeft(2, '0')),
        _label('seconds'),
        Count(seconds.toString().padLeft(2, '0')),
      ],
    );
  }

  Widget _eventName(name) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        name,
        style: TextStyle(fontSize: 64, color: Color(0xff7A90A3)),
      ),
    );
  }

  Widget _label(label) {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 10),
      child: Text(label),
    );
  }
}

class Count extends HookWidget {
  final String count;

  Count(this.count);

  @override
  Widget build(BuildContext context) {
    var s = count.split('');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[for (String num in s) Number(num)],
    );
  }
}

class Number extends HookWidget {
  final String num;

  Number(this.num);

  @override
  Widget build(BuildContext context) {
    var prev = useState('');

    var controller =
        useAnimationController(duration: Duration(milliseconds: 400));
    var value = useAnimation(Tween(begin: 0.0, end: 1.0).animate(CurveTween(
      curve: Curves.bounceOut,
    ).animate(controller)));

    useEffect(() {
      controller.forward();
    }, []);

    useValueChanged(num, (prevValue, nextValue) {
      prev.value = prevValue;
      controller.reset();
      controller.forward();
    });

    return Container(
      width: 59,
      height: 78,
      margin: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        overflow: Overflow.clip,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: -78 * value,
            bottom: 78 * value,
            child: Center(
              child: Text('${prev.value}', style: TextStyle(fontSize: 64)),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 78 * (1 - value),
            bottom: -78 * (1 - value),
            child: Center(
              child: Text('$num', style: TextStyle(fontSize: 64)),
            ),
          ),
        ],
      ),
    );
  }
}

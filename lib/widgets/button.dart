import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Button extends HookWidget {
  final VoidCallback onPressed;
  final Widget child;

  Button({this.onPressed, this.child});

  Widget build(BuildContext context) {
    var pressed = useState(false);
    return GestureDetector(
      onTap: onPressed,
      onTapDown: (details) {
        pressed.value = true;
      },
      onTapUp: (details) {
        pressed.value = false;
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(64, 0, 0, 0),
              offset: Offset(0, pressed.value ? 0 : 2),
              blurRadius: pressed.value ? 0 : 2,
            )
          ],
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: DefaultTextStyle(
            child: child,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

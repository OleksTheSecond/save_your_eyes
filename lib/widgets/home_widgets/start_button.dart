import 'package:flutter/material.dart';
import 'package:save_your_eyes/const.dart';
import 'package:save_your_eyes/exceptions/timer_exception.dart';

class HomeStartButton extends StatelessWidget {
  const HomeStartButton({
    super.key,
    required this.isStarted,
    required this.changeIsStarted,
  });
  final bool isStarted;
  final Function(bool isStarted) changeIsStarted;

  _buttonStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: isStarted ? mainRed : mainGreen,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }

  _errorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: mainRed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: _buttonStyle(),
        onPressed: () {
          try {
            changeIsStarted(!isStarted);
          } on TimerException catch (exception) {
            _errorMessage(context, exception.error);
          }
        },
        child: FittedBox(
          fit: BoxFit.cover,
          child: Text(
            isStarted ? "STOP" : "START",
            style: const TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}

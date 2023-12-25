import 'dart:ui';
import 'package:flutter/material.dart';

class TimePickerButton extends StatelessWidget {
  const TimePickerButton({
    super.key,
    required this.time,
    required this.changeTime,
    required this.text,
    this.entryMode = TimePickerEntryMode.dial,
  });

  final TimeOfDay time;
  final Function(TimeOfDay time) changeTime;
  final TimePickerEntryMode entryMode;
  final String text;

  _buildTextColumn(int hour, int minute) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
        Text(
          '${hour <= 9 ? "0$hour" : hour} : ${minute <= 9 ? "0$minute" : minute}',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 35,
              letterSpacing: 3,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  _containerDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(
        width: 1.5,
        color: Colors.white.withOpacity(0.2),
      ),
    );
  }

  _onTap(BuildContext context) {
    showTimePicker(
            context: context, initialTime: time, initialEntryMode: entryMode)
        .then((newTime) {
      if (newTime != null) {
        changeTime(newTime);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => _onTap(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: _containerDecoration(),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: _buildTextColumn(time.hour, time.minute),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

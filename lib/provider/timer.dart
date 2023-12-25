import 'dart:async';
import 'package:flutter/material.dart';
import 'package:save_your_eyes/exceptions/timer_exception.dart';
import 'package:save_your_eyes/notification/notifications.dart';

class TimerProvider extends ChangeNotifier {
  //Час початку з котрого будуть приходити сповіщення
  TimeOfDay _currentStartTime = const TimeOfDay(hour: 0, minute: 0);

  //Час до якого приходять сповіщення
  TimeOfDay _currentEndTime = const TimeOfDay(hour: 0, minute: 0);

  //Час між сповіщеннями
  TimeOfDay _period = const TimeOfDay(hour: 0, minute: 0);

  bool _isStarted = false;

  TimeOfDay get currentStartTime => _currentStartTime;
  TimeOfDay get currentEndTime => _currentEndTime;
  TimeOfDay get period => _period;
  bool get isStarted => _isStarted;

  //Таймер
  Timer? _timer;

  TimerProvider();

  void changeStartTime(TimeOfDay newStartTime) {
    _currentStartTime = newStartTime;
    _stopTimer();
    notifyListeners();
  }

  void changeEndTime(TimeOfDay newEndTime) {
    _currentEndTime = newEndTime;
    _stopTimer();
    notifyListeners();
  }

  void changePeriod(TimeOfDay newPeriod) {
    _period = newPeriod;
    _stopTimer();
    notifyListeners();
  }

  void changeIsStarted(bool isStarted) {
    if (_period.hour == 0 && _period.minute == 0) {
      throw const TimerException("Оберіть не нульові значення");
    }
    if ((_currentStartTime.hour * 60 + _currentStartTime.minute) >=
        (_currentEndTime.hour * 60 + _currentEndTime.minute)) {
      throw const TimerException(
          "Початковий час повинен бути менший ніж кінечний");
    }
    if (_period.hour * 60 + _period.minute >=
        (_currentEndTime.hour * 60 + _currentEndTime.minute) -
            (_currentStartTime.hour * 60 + _currentStartTime.minute)) {
      throw const TimerException("Періодичність повинна бути меншою");
    }

    _isStarted = isStarted;

    if (isStarted) {
      startTimer();
    } else {
      _stopTimer();
    }

    notifyListeners();
  }

  //Запуск таймеру
  void startTimer() {
    _timer = Timer(Duration(hours: _period.hour, minutes: _period.minute), () {
      final now = TimeOfDay.now();
      if (_isStarted &&
          (now.hour * 60 + now.minute) >
              (_currentStartTime.hour * 60 + _currentStartTime.minute) &&
          (now.hour * 60 + now.minute) <
              (_currentEndTime.hour * 60 + _currentEndTime.minute)) {
        showNotification();
        changeIsStarted(_isStarted);
      }
    });
  }

  //Сповіщення
  void showNotification() {
    Notifications()
        .showNotification(title: "Перепочинь", body: "Зроби зарядку для очей.");
  }

  //Зупинка таймеру
  void _stopTimer() {
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer!.cancel();
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_your_eyes/const.dart';
import 'package:save_your_eyes/provider/timer.dart';
import 'package:save_your_eyes/widgets/home_widgets/start_button.dart';
import 'package:save_your_eyes/widgets/home_widgets/time_picker_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  _buildAppBar() {
    return AppBar(
      title: const Text(
        "Eyes Reminder",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: mainGreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentStartTime = context.watch<TimerProvider>().currentStartTime;
    final currentEndTime = context.watch<TimerProvider>().currentEndTime;
    final period = context.watch<TimerProvider>().period;
    final isStarted = context.watch<TimerProvider>().isStarted;

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [mainDarkGreen, mainGreen])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TimePickerButton(
                      time: currentStartTime,
                      changeTime: context.read<TimerProvider>().changeStartTime,
                      text: 'ЧАС ПОЧАТКУ СПОВІЩЕНЬ'),
                  TimePickerButton(
                      time: currentEndTime,
                      changeTime: context.read<TimerProvider>().changeEndTime,
                      text: 'ЧАС КІНЦЯ СПОВІЩЕНЬ'),
                  TimePickerButton(
                    time: period,
                    changeTime: context.read<TimerProvider>().changePeriod,
                    text: 'ПЕРІОДИЧНІСТЬ СПОВІЩЕНЬ',
                    entryMode: TimePickerEntryMode.inputOnly,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: HomeStartButton(
                          isStarted: isStarted,
                          changeIsStarted:
                              context.read<TimerProvider>().changeIsStarted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

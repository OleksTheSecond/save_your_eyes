import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_your_eyes/const.dart';
import 'package:save_your_eyes/notification/notifications.dart';
import 'package:save_your_eyes/provider/timer.dart';
import 'package:save_your_eyes/widgets/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Notifications().initNotifications();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: mainGreen),
      home: ChangeNotifierProvider<TimerProvider>(
        create: (_) => TimerProvider(),
        child: const HomePage(),
      ),
    );
  }
}

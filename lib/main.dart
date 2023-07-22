import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/data/model/task.dart';
import 'package:note_app/data/model/task_type.dart';
import 'package:note_app/data/model/type_enum.dart';
import 'package:note_app/screens/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  await Hive.openBox<Task>('taskBox');
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}

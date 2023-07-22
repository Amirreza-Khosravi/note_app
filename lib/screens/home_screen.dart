import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/screens/add_task_screen.dart';
import 'package:note_app/data/model/task.dart';
import 'package:note_app/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = TextEditingController();
  String inputText = '';

  var taskbox = Hive.box<Task>('taskBox');
  bool isFabVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: taskbox.listenable(),
          builder: (context, value, child) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                setState(() {
                  if (notification.direction == ScrollDirection.forward) {
                    isFabVisible = true;
                  }
                  if (notification.direction == ScrollDirection.reverse) {
                    isFabVisible = false;
                  }
                });
                return true;
              },
              child: ListView.builder(
                itemCount: taskbox.values.length,
                itemBuilder: ((context, index) {
                  var task = taskbox.values.toList()[index];
                  return getListItem(task);
                }),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => AddTask()),
              ),
            );
          },
          backgroundColor: Color(0xff18DAA3),
          child: Image.asset('images/icon_add.png'),
        ),
      ),
    );
  }

  Widget getListItem(Task task) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        task.delete();
      },
      child: TaskWidget(task: task),
    );
  }
}

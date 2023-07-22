import 'package:flutter/material.dart';
import 'package:note_app/data/model/task_type.dart';

class getTaskTypeItemList extends StatelessWidget {
  getTaskTypeItemList(
      {Key? key,
      required this.taskType,
      required this.index,
      required this.selectedItemList})
      : super(key: key);
  final TaskType taskType;
  final int index;
  final int selectedItemList;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: (selectedItemList == index)
              ? Color.fromARGB(255, 0, 150, 107)
              : Colors.grey,
          width: (selectedItemList == index) ? 3 : 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(8),
      width: 100,
      child: Column(
        children: [
          Image.asset(taskType.image),
          Text(
            taskType.title,
            style: TextStyle(
              fontWeight: (selectedItemList == index)
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

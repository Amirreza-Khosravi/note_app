import 'package:flutter/material.dart';
import 'package:note_app/screens/edit_task_screen.dart';
import 'package:note_app/data/model/task.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({Key? key, required this.task}) : super(key: key);
  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return getTaskItem();
  }

  Widget getTaskItem() {
    return GestureDetector(
      onTap: (() {
        setState(() {
          isBoxChecked = !isBoxChecked;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      }),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: getMainContent(),
      ),
    );
  }

  Row getMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                          checkColor: Colors.white,
                          activeColor: Color.fromARGB(255, 5, 167, 121),
                          value: isBoxChecked,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onChanged: (isCheked) {
                            setState(() {
                              isBoxChecked = !isBoxChecked;
                              widget.task.isDone = isBoxChecked;
                              widget.task.save();
                            });
                          }),
                    ),
                    Text(widget.task.title),
                  ],
                ),
                Text(
                  widget.task.subTitle,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                getTimeAndEditBadgs(),
              ],
            ),
          ),
        ),
        Image.asset(widget.task.taskType.image),
      ],
    );
  }

  Row getTimeAndEditBadgs() {
    return Row(
      children: [
        Container(
          width: 93,
          height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xff18DAA3),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                Text(
                  '${getHourUnderTen(widget.task.time)}:${getMinUnderTen(widget.task.time)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 10),
                Image.asset('images/icon_time.png'),
              ],
            ),
          ),
        ),
        SizedBox(width: 15),
        InkWell(
          onTap: (() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) {
                  return EditTask(task: widget.task);
                }),
              ),
            );
          }),
          child: Container(
            width: 93,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xffffffff),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'ویرایش',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff18DAA3),
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset('images/icon_edit.png'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //for to fix minute under 10
  String getMinUnderTen(DateTime time) {
    if (time.minute < 10) {
      return '0${time.minute}';
    } else {
      return time.minute.toString();
    }
  }

  //for to fix hour under 10
  String getHourUnderTen(DateTime time) {
    if (time.hour < 10) {
      return '0${time.hour}';
    } else {
      return time.hour.toString();
    }
  }
}
